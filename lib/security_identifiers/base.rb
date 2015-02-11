module SecurityIdentifiers

  class InvalidFormat < StandardError; end
  class InvalidConversion < StandardError; end

  class Base

    attr_reader :original_check_digit

    def valid?
      @original_check_digit.to_i == check_digit
    end

    def to_s
      "#{@identifier}#{check_digit}"
    end

    private

      def digits
        @digits ||= @identifier.split('').map { |i| i.match(/[A-Z]/) ? (i.ord - 55) : i.to_i }
      end

      def even_values
        @even_values ||= digits.values_at(* digits.each_index.select { |i| i.even? })
      end

      def odd_values
        @odd_values ||= digits.values_at(* digits.each_index.select { |i| i.odd? })
      end

      def fix!
        @original_check_digit = check_digit
      end

  end

end
