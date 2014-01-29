require 'spec_helper'

describe SEDOL do

  it 'is invalid without 6 character alpha-numeric identifier' do
    expect { SEDOL.new('B0WNL') }.to raise_error(SecurityIdentifiers::InvalidFormat)
  end

  context 'Without a check digit' do
    let(:sedol) { SEDOL.new('B0WNLY') }

    it 'is invalid' do
      expect(sedol).to_not be_valid
    end
  end

  context 'Valid numeric codes' do
    let(:sedol) { SEDOL.new('B0WNLY7') }

    it 'calculates the check digit' do
      expect(sedol.check_digit).to eql(sedol.original_check_digit.to_i)
    end

    it 'validates the check digit' do
      expect(sedol).to be_valid
    end
  end

  context '#to_isin' do
    let(:sedol) { SEDOL.new('B0WNLY7') }

    it 'returns an ISIN' do
      expect(sedol.to_isin('GB')).to be_instance_of(ISIN)
    end

    it 'calculates the ISIN check digit' do
      expect(sedol.to_isin('GB').check_digit).to_not be_nil
    end

    it 'raises an error when an invalid country code is supplied' do
      expect { sedol.to_isin('US') }.to raise_error(SecurityIdentifiers::InvalidConversion)
    end
  end

  context '#to_s' do
    let(:sedol) { SEDOL.new('B0WNLY7') }

    it 'returns the whole identifier' do
      expect(sedol.to_s).to eql('B0WNLY7')
    end
  end

  context '#fix!' do
    let(:sedol) { SEDOL.new('B0WNLY') }

    it 'calculates the check digit' do
      expect { sedol.fix! }.to change(sedol, :original_check_digit).from(nil).to(7)
    end
  end

end