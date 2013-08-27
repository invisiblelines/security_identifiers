module ISIN

  class Validator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      isin = ISIN.new(value)

      unless isin.valid_format?
        record.errors[attribute] << 'is not in the correct format'
      end

      unless isin.valid?
        record.errors[attribute] << 'does not have a valid check digit'
      end
    end

  end

end