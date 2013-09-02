require 'spec_helper'

describe ISIN::Validator do

  it 'is invalid without a country code' do
    expect { ISIN::Validator.new('120378331004') }.to raise_error(SecurityIdentifiers::InvalidFormat)
  end

  it 'is invalid without 9 character alpha-numeric identifier' do
    expect { ISIN::Validator.new('US037833105') }.to raise_error(SecurityIdentifiers::InvalidFormat)
  end

  it 'is invalid without a check digit' do
    expect { ISIN::Validator.new('US037833100') }.to raise_error(SecurityIdentifiers::InvalidFormat)
  end
  
  context 'Valid numeric ISIN' do

    let(:isin) { ISIN::Validator.new('US0378331005') }

    it 'calculates the check digit' do
      expect(isin.check_digit).to eql(5)
    end

    it 'validates the check digit' do
      expect(isin.valid?).to be_true
    end

  end

  context 'Valid alphanumeric ISIN' do

    let(:isin) { ISIN::Validator.new('AU0000XVGZA3') }

    it 'calculates the check digit' do
      expect(isin.check_digit).to eql(3)
    end

    it 'validates the check digit' do
      expect(isin.valid?).to be_true
    end

  end

  context 'Invalid check digit' do

    let(:isin) { ISIN::Validator.new('US0378331004') }

    it 'validates the check digit' do
      expect(isin.valid?).to be_false
    end

  end

end