require 'spec_helper'

describe ISIN do

  it 'is invalid without a country code' do
    expect { ISIN.new('120378331004') }.to raise_error(SecurityIdentifiers::InvalidFormat)
  end

  it 'is invalid without 9 character alpha-numeric identifier' do
    expect { ISIN.new('US03783315') }.to raise_error(SecurityIdentifiers::InvalidFormat)
  end

  context 'Without a check digit' do
    let(:isin) { ISIN.new('US037833100') }

    it 'is invalid' do
      expect(isin).to_not be_valid
    end
  end

  context 'Valid numeric ISIN' do
    let(:isin) { ISIN.new('US0378331005') }

    it 'calculates the check digit' do
      expect(isin.check_digit).to eql(5)
    end

    it 'validates the check digit' do
      expect(isin).to be_valid
    end
  end

  context 'Valid alphanumeric ISIN' do
    let(:isin) { ISIN.new('AU0000XVGZA3') }

    it 'calculates the check digit' do
      expect(isin.check_digit).to eql(3)
    end

    it 'validates the check digit' do
      expect(isin).to be_valid
    end
  end

  context 'Invalid check digit' do
    let(:isin) { ISIN.new('US0378331004') }

    it 'validates the check digit' do
      expect(isin).to_not be_valid
    end
  end

  context '#to_s' do
    let(:isin) { ISIN.new('AU0000XVGZA3') }

    it 'returns the whole identifier' do
      expect(isin.to_s).to eql('AU0000XVGZA3')
    end
  end

  context '#fix!' do
    let(:isin) { ISIN.new('AU0000XVGZA') }

    it 'calculates the check digit' do
      expect { isin.fix! }.to change(isin, :original_check_digit).from(nil).to(3)
    end
  end

end
