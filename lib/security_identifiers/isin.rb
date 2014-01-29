module SecurityIdentifiers

  class ISIN < Base

    def initialize(str)
      raise InvalidFormat if str.nil?
      
      match_data = str.upcase.match(/^(([A-Z]{2})([A-Z0-9]{9}))(\d{1})?$/)

      raise InvalidFormat if match_data.nil?

      @identifier, @country_code, @nsin, @original_check_digit = match_data.captures
    end

    def check_digit
      longest, shortest = if even_values.last == digits.last
         [even_values, odd_values]
      else
        [odd_values, even_values]
      end

      longest = longest.map { |i| i * 2 }
      values  = (longest.concat(shortest)).to_s.scan(/./).map(&:to_i)
      sum     = values.inject(&:+)
      
      (10 - (sum % 10)) % 10
    end

    protected

      def digits
        @digits ||= super.join('').split('').map(&:to_i)
      end

  end

end