module SecurityIdentifiers
  class ISIN < Base
    def initialize(str)
      raise InvalidFormat if str.nil?

      match_data = str.upcase.match(/^(([A-Z]{2})([A-Z0-9]{9}))(\d{1})?$/)

      raise InvalidFormat if match_data.nil?

      @identifier, @country_code, @nsin, @original_check_digit = match_data.captures

      fix! if @original_check_digit.nil?
    end

    def check_digit
      first_group, second_group = digit_groups
      first_group.map! { |d| d * 2 }

      sum = (first_group + second_group).join.each_char.inject(0) { |result, i| result + i.to_i }

      mod_10(sum)
    end

    private

    def digit_groups
      if digits.size.even?
        [even_values, odd_values]
      else
        [odd_values, even_values]
      end
    end
  end
end
