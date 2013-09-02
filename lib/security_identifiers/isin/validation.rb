module SecurityIdentifiers
  
  module ISIN

    class Validation < ActiveModel::EachValidator

      def validate_each(record, attribute, value)
        begin
          isin = ISIN.new(value)
        rescue SecurityIdentifiers::InvalidFormat
          record.errors[attribute] << 'is not in the correct format'
        end

        unless isin.valid?
          record.errors[attribute] << 'does not have a valid check digit'
        end
      end

    end

  end

end