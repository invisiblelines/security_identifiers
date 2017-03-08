module SecurityIdentifiers
  module Validations
    class IsinValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        isin = ISIN.new(value)

        record.errors[attribute] << 'does not have a valid check digit' unless isin.valid?
      rescue SecurityIdentifiers::InvalidFormat
        record.errors[attribute] << 'is not in the correct format'
      end
    end
  end
end
