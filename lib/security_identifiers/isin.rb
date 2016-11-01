module SecurityIdentifiers

  class ISIN < Base

    def initialize(str)
      raise InvalidFormat if str.nil?

      match_data = str.upcase.match(/^(([A-Z]{2})([A-Z0-9]{9}))(\d{1})?$/)

      raise InvalidFormat if match_data.nil?

      @identifier, @country_code, @nsin, @original_check_digit = match_data.captures

      fix! if @original_check_digit.nil?
    end

    def digits_for c
      @@digits_cache ||= {}
      @@digits_cache[c] ||= if c[/\d/]
	c.to_i
      else
	ord = c.ord - 55
	[ord/10, ord%10]
      end
    end

    def check_digit
      # ISIN Orgnization algorithm (http://www.isin.org/education/)
      # NB.  Digits are reversed because even/odd is counted starting with the rightmost character
      digits_digits = @identifier.chars.collect{|c| digits_for(c)}.flatten.reverse
      odd_digits  = digits_digits.values_at(* digits_digits.each_index.select {|i| i.odd?})
      even_digits = digits_digits.values_at(* digits_digits.each_index.select {|i| i.even?})
      even_digits_doubled = even_digits.collect{|d| d >= 5 ? [1, (d-5)*2] : d*2 }.flatten
      sum   = (odd_digits + even_digits_doubled).inject(&:+)
      value = 10 * ((sum+9)/10) 		# parentheses matter!
      value - sum
    end

    protected

      def digits
        @digits ||= super.join('').split('').map(&:to_i)
      end

  end

end
