class ::ISIN

  Format = /^[A-Z]{2}\d{10}$/

  def initialize(str)
    @isin = str
  end

  def check_digit
    longest, shortest = (even_values.last == digits.last ? [even_values, odd_values] : [odd_value, even_values])
    longest           = longest.join('').split('').map(&:to_i).map { |i| i * 2 }
    10 - (longest.concat(shortest).join('').split('').map(&:to_i).sum % 10)
  end

  def valid?
    @isin[-1].to_i == check_digit
  end

  def valid_format?
    !!(@isin =~ Format)
  end

  private

    def digits
      @digits ||= begin
        values = @isin[0...-1].split('').map { |i| i.match(/[A-Z]/) ? (i.ord - 55) : i.to_i }
        values.join('').split('').map(&:to_i)
      end
    end

    def even_values
      @even_values ||= digits.values_at(* digits.each_index.select {|i| i.even?})
    end

    def odd_values
      @odd_values ||= digits.values_at(* digits.each_index.select {|i| i.odd?})
    end

end