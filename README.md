# Security Identifiers

[![Build Status](https://travis-ci.org/invisiblelines/security_identifiers.png?branch=master)](https://travis-ci.org/invisiblelines/security_identifiers)
[![Code Climate](https://codeclimate.com/github/invisiblelines/security_identifiers.png)](https://codeclimate.com/github/invisiblelines/security_identifiers)
[![Dependency Status](https://gemnasium.com/invisiblelines/security_identifiers.png)](https://gemnasium.com/invisiblelines/security_identifiers)

Security identifiers validation library for Ruby. 

Currently supports

- ISIN
- CUSIP
- SEDOL

Validates:

-  Format
-  Check Digit

## Installation

Add this line to your application's Gemfile:

    gem 'security_identifiers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install security_identifiers

## Usage

To validate an ISIN

    isin = SecurityIdentifiers::ISIN.new('US0378331005')
    isin.valid? # => true

or with an invalid identifier

    isin = SecurityIdentifiers::ISIN.new('S0378331005') # => raises SecurityIdentifiers::InvalidFormat

To fix a missing check digit

    isin = SecurityIdentifiers::ISIN.new('US037833100')
    isin.fix! 

Now you can validate

    isin.valid? # => true

The same method apply to CUSIPs and SEDOLs.

CUSIPs and SEDOLs also support converting these identifiers to ISINs.

    cusip = SecurityIdentifiers::CUSIP.new('125509BG3')
    cusip.to_isin('US') # => SecurityIdentifiers::ISIN

## ActiveModel Validations

Includes custom validators for use in ActiveModel/ActiveRecord

    class MyModel < ActiveRecord::Base
      include SecurityIdentifiers::Validators
    
      validates :isin, isin: true
      validates :cusip, cusip: true
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
