module SecurityIdentifiers
  class CUSIP < Base
    def initialize(str)
      raise InvalidFormat if str.nil?

      match_data = str.upcase.match(/^([A-Z0-9]{8})(\d{1})?$/)

      raise InvalidFormat if match_data.nil?

      @identifier, @original_check_digit = match_data.captures

      fix! if @original_check_digit.nil?
    end

    def check_digit
      values = even_values.map { |i| i * 2 }.zip(odd_values).flatten

      sum = values.inject(0) do |result, i|
        result + (i / 10) + i % 10
      end

      mod_10(sum)
    end

    def to_isin(iso = 'US')
      raise InvalidConversion unless %w(US CA).include?(iso)

      ISIN.new([iso, @identifier, check_digit].join)
    end
  end
end
