module ISIN

  class Railtie < Rails::Railtie

    initializer 'isin.initialize' do |app|
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, ISIN::Validator
      end
    end

  end

end