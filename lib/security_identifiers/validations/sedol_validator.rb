module SecurityIdentifiers
  
  module Validations

    class SedolValidator < ActiveModel::EachValidator

      def validate_each(record, attribute, value)
        begin
          sedol = SEDOL.new(value)

          unless sedol.valid?
            record.errors[attribute] << 'does not have a valid check digit'
          end
        rescue SecurityIdentifiers::InvalidFormat
          record.errors[attribute] << 'is not in the correct format'
        end
      end

    end

  end

end