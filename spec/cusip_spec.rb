require 'spec_helper'

describe CUSIP do
  it 'is invalid without 8 character alpha-numeric identifier' do
    expect { CUSIP.new('5509BG3') }.to raise_error(SecurityIdentifiers::InvalidFormat)
  end

  context 'Without a check digit' do
    let(:cusip) { CUSIP.new('83764912') }

    it 'calculates the check digit' do
      expect(cusip.original_check_digit).to_not be_nil
    end
  end

  context 'Valid numeric codes' do
    let(:cusip) { CUSIP.new('837649128') }

    it 'calculates the check digit' do
      expect(cusip.check_digit).to eql(cusip.original_check_digit.to_i)
    end

    it 'validates the check digit' do
      expect(cusip).to be_valid
    end
  end

  context 'Valid alphanumeric codes' do
    let(:cusip) { CUSIP.new('125509BG3') }

    it 'calculates the check digit' do
      expect(cusip.check_digit).to eql(cusip.original_check_digit.to_i)
    end

    it 'validates the check digit' do
      expect(cusip).to be_valid
    end
  end

  context 'Valid PPN codes' do
    let(:cusip) { CUSIP.new('00800*AA6') }

    it 'calculates the check digit' do
      expect(cusip.check_digit).to eql(cusip.original_check_digit.to_i)
    end

    it 'validates the check digit' do
      expect(cusip).to be_valid
    end
  end

  context 'Invalid check digit' do
    let(:cusip) { CUSIP.new('125509BG4') }

    it 'validates the check digit' do
      expect(cusip).to_not be_valid
    end
  end

  context '#to_isin' do
    let(:cusip) { CUSIP.new('125509BG3') }

    it 'returns an ISIN' do
      expect(cusip.to_isin('US')).to be_instance_of(SecurityIdentifiers::ISIN)
    end

    it 'calculates the ISIN check digit' do
      expect(cusip.to_isin('US').check_digit).to_not be_nil
    end

    it 'raises an error when an invalid country code is supplied' do
      expect { cusip.to_isin('GB') }.to raise_error(SecurityIdentifiers::InvalidConversion)
    end
  end

  context '#to_s' do
    let(:cusip) { CUSIP.new('125509BG3') }

    it 'returns the whole identifier' do
      expect(cusip.to_s).to eql('125509BG3')
    end
  end
end
