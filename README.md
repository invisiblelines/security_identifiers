# Security Identifiers

Security identifiers validation library for Ruby. 

Currently supports
• ISIN
• CUSIP

Validates:
• Format
• Check Digit

## Installation

Add this line to your application's Gemfile:

    gem 'security_identifiers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install security_identifiers

## Usage

To validate an ISIN

    isin = SecurityIdentifiers::ISIN::Validator.new('US0378331005')
    isin.valid? # => true

or

    isin = SecurityIdentifiers::ISIN::Validator.new('S0378331005') # => raises SecurityIdentifiers::InvalidFormat

To validate a CUSIP

    cusip = SecurityIdentifiers::CUSIP::Validator.new('837649128')
    cusip.valid? # => true

## Rails

Includes custom validators for use in ActiveRecord

    class MyModel < ActiveRecord::Base
      validates :isin, isin: true
      validates :cusip, cusip: true
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
