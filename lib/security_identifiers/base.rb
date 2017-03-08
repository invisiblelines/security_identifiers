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

    def digits_for(char)
      return char.to_i unless char =~ /[A-Z]/

      ord = char.to_i(36)
      [ord / 10, ord % 10]
    end

    def digits
      @digits ||= @identifier.each_char.flat_map { |char| digits_for(char) }
    end

    def even_values
      @even_values ||= digits.select.with_index(1) { |digit, i| i.even? && digit }
    end

    def odd_values
      @odd_values ||= digits.select.with_index(1) { |digit, i| i.odd? && digit }
    end

    def fix!
      @original_check_digit = check_digit
    end

    def mod_10(sum)
      (10 - sum % 10) % 10
    end
  end
end
