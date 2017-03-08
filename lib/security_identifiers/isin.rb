module SecurityIdentifiers
  class ISIN < Base
    def initialize(str)
      raise InvalidFormat if str.nil?

      match_data = str.upcase.match(/^(([A-Z]{2})([A-Z0-9]{9}))(\d{1})?$/)

      raise InvalidFormat if match_data.nil?

      @identifier, @country_code, @nsin, @original_check_digit = match_data.captures

      fix! if @original_check_digit.nil?
    end

    def digits_for(char)
      return char.to_i unless char =~ /[A-Z]/

      ord = char.to_i(36)
      [ord / 10, ord % 10]
    end

    def check_digit
      # ISIN Orgnization algorithm (http://www.isin.org/education/)
      # NB.  Digits are reversed because even/odd is counted starting with the rightmost character
      even_digits_doubled = even_values.collect { |d| d >= 5 ? [1, (d - 5) * 2] : d * 2 }.flatten
      sum                 = (odd_values + even_digits_doubled).inject(&:+)
      value               = 10 * ((sum + 9) / 10)
      value - sum
    end

    protected

    def digits
      @digits ||= super.join('').split('').map(&:to_i).reverse
    end
  end
end
