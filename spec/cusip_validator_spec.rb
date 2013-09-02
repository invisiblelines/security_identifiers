require 'spec_helper'

describe CUSIP::Validator do

  it 'is invalid without 8 character alpha-numeric identifier' do
    expect { CUSIP::Validator.new('5509BG3') }.to raise_error(SecurityIdentifiers::InvalidFormat)
  end

  it 'is invalid without a check digit' do
    expect { CUSIP::Validator.new('125509BG') }.to raise_error(SecurityIdentifiers::InvalidFormat)
  end

  context 'Valid numeric codes' do

    let(:cusip) { CUSIP::Validator.new('837649128') }

    it 'calculates the check digit' do
      expect(cusip.check_digit).to eql(8)
    end

    it 'validates the check digit' do
      expect(cusip.valid?).to be_true
    end

  end

  context 'Valid alphanumeric codes' do

    let(:cusip) { CUSIP::Validator.new('125509BG3') }

    it 'calculates the check digit' do
      expect(cusip.check_digit).to eql(3)
    end

    it 'validates the check digit' do
      expect(cusip.valid?).to be_true
    end

  end

end