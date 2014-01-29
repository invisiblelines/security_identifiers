module SecurityIdentifiers

  class CUSIP < Base

    def initialize(str)
      raise InvalidFormat if str.nil?
      
      match_data = str.upcase.match(/^([A-Z0-9]{8})(\d{1})?$/)

      raise InvalidFormat if match_data.nil?

      @identifier, @original_check_digit = match_data.captures
    end

    def check_digit
      values = odd_values.map { |i| i * 2 }.zip(even_values).flatten

      values = values.inject(0) do |sum, i|
        sum += (i / 10) + i % 10
      end

      ((10 - values) % 10) % 10
    end

    def to_isin(iso = 'US')
      raise InvalidConversion if !['US', 'CA'].include?(iso)

      ISIN.new([iso, @identifier, check_digit].join)
    end

  end

end