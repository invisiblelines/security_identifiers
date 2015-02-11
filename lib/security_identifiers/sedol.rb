module SecurityIdentifiers

  class SEDOL < Base

    def initialize(str)
      raise InvalidFormat if str.nil?

      match_data = str.upcase.match(/^([A-Z0-9]{6})(\d{1})?$/)

      raise InvalidFormat if match_data.nil?

      @identifier, @original_check_digit = match_data.captures

      fix! if @original_check_digit.nil?
    end

    def check_digit
      weights = [1, 3, 1, 7, 3, 9, 1]
      sum     = 0

      digits.each_with_index do |i, idx|
        sum += weights[idx] * i
      end

      (10 - sum % 10) % 10
    end

    def to_isin(iso='GB')
      raise InvalidConversion if !['GB', 'IE'].include?(iso)

      ISIN.new([iso, '00', @identifier, check_digit].join)
    end

  end

end
