module SecurityIdentifiers

  class InvalidFormat < StandardError; end

  class BaseValidator

    def valid?
      @check_digit.to_i == check_digit
    end

    private

      def digits
        @digits ||= begin
          digits = @identifier.split('').map { |i| i.match(/[A-Z]/) ? (i.ord - 55) : i.to_i }
          digits.join('').split('').map(&:to_i)
        end
      end

      def even_values
        @even_values ||= digits.values_at(* digits.each_index.select { |i| i.even? })
      end

      def odd_values
        @odd_values ||= digits.values_at(* digits.each_index.select { |i| i.odd? })
      end

  end

end