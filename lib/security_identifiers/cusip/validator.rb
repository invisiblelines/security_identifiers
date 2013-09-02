module SecurityIdentifiers

  module CUSIP

    Format = /^(?<identifier>[a-zA-Z0-9]{8})(?<check_digit>\d{1})$/

    class Validator < SecurityIdentifiers::BaseValidator

      def initialize(str)
        match_data = str.match(Format)

        raise InvalidFormat if match_data.nil?

        @identifier, @check_digit = match_data.captures
      end

      def check_digit
        @check ||= begin
          values = odd_values.map { |i| i * 2 }.zip(even_values).flatten

          values = values.inject(0) do |sum, i|
            sum += (i / 10) + i % 10
          end

          ((10 - values) % 10) % 10
        end
      end

    end

  end

end