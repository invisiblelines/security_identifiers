# ISIN

ISIN validation library for Ruby.

Validates:
• Format
• Checksum

## Installation

Add this line to your application's Gemfile:

    gem 'isin'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install isin

## Usage

To validate an ISIN

    ISIN::Validation.new('US0378331005').valid? # => true

    ISIN::Validation.new('US0378331005').valid_format? # => true

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
