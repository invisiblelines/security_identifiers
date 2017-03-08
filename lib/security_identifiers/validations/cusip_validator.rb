module SecurityIdentifiers
  module Validations
    class CusipValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        cusip = CUSIP.new(value)

        record.errors[attribute] << 'does not have a valid check digit' unless cusip.valid?
      rescue SecurityIdentifiers::InvalidFormat
        record.errors[attribute] << 'is not in the correct format'
      end
    end
  end
end
