require 'bundler/setup'
require 'active_model'
require 'security_identifiers'

include SecurityIdentifiers

class Security
  include ActiveModel::Validations
  include SecurityIdentifiers::Validations

  attr_accessor :cusip, :isin, :sedol

  def initialize(options = {})
    @cusip = options[:cusip]
    @isin  = options[:isin]
    @sedol = options[:sedol]
  end

  validates :cusip, cusip: true, allow_blank: true
  validates :isin,  isin:  true, allow_blank: true
  validates :sedol, sedol: true, allow_blank: true
end