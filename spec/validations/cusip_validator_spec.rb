require 'spec_helper'

describe Validations::CusipValidator do

  context 'with invalid cusip' do

    subject { Security.new(cusip: '5509BG3') }

    it 'is invalid' do
      expect(subject).not_to be_valid
    end
  end

  context 'with cusip' do

    subject { Security.new(cusip: '125509BG3') }

    it 'is valid' do
      expect(subject).to be_valid
    end
  end

end