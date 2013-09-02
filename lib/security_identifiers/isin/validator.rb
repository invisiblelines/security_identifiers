module SecurityIdentifiers

  module ISIN

    Format = /^(?<identifier>(?<country_code>[A-Z]{2})(?<nsin>[a-zA-Z0-9]{9}))(?<check_digit>\d{1})$/

    class Validator < SecurityIdentifiers::BaseValidator

      def initialize(str)
        match_data = str.match(Format)

        raise InvalidFormat if match_data.nil?

        @identifier, @country_code, @nsin, @check_digit = match_data.captures
      end

      def check_digit
        longest, shortest = if even_values.last == digits.last
           [even_values, odd_values]
        else
          [odd_values, even_values]
        end

        longest           = longest.map { |i| i * 2 }
        values            = (longest.concat(shortest)).to_s.scan(/./).map(&:to_i)
        sum               = values.inject(&:+)
        
        (10 - (sum % 10)) % 10
      end

    end

  end

end