require 'spec_helper'

describe Validations::IsinValidator do
  context 'without isin' do
    subject { Security.new(isin: 'US03783310') }

    it 'is invalid' do
      expect(subject).not_to be_valid
    end
  end

  context 'with isin' do
    subject { Security.new(isin: 'US0378331005') }

    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end
