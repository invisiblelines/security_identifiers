module SecurityIdentifers

  class Railtie < Rails::Railtie

    initializer 'security_identifers.initialize' do |app|
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, SecurityIdentifers::ISIN::Validation
        ActiveRecord::Base.send :include, SecurityIdentifers::CUSIP::Validation
      end
    end

  end

end