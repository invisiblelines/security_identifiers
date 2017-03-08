module SecurityIdentifiers
  class SEDOL < Base
    WEIGHTS = [1, 3, 1, 7, 3, 9, 1].freeze

    def initialize(str)
      raise InvalidFormat if str.nil?

      match_data = str.upcase.match(/^([A-Z0-9]{6})(\d{1})?$/)

      raise InvalidFormat if match_data.nil?

      @identifier, @original_check_digit = match_data.captures

      fix! if @original_check_digit.nil?
    end

    def check_digit
      sum = digits.each_with_index.inject(0) do |result, (i, idx)|
        result + WEIGHTS[idx] * i
      end

      mod_10(sum)
    end

    def to_isin(iso = 'GB')
      raise InvalidConversion unless %w(GB IE).include?(iso)

      ISIN.new([iso, '00', @identifier, check_digit].join)
    end

    private

    def digits_for(char)
      char =~ /[A-Z]/ ? char.to_i(36) : char.to_i
    end
  end
end
