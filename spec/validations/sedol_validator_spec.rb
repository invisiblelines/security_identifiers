require 'spec_helper'

describe Validations::SedolValidator do

  context 'without sedol' do
    subject { Security.new(sedol: 'BOWN') }
    
    it 'is invalid' do
      expect(subject).not_to be_valid
    end
  end

  context 'with sedol' do

    subject { Security.new(sedol: 'B0WNLY7') }

    it 'is valid' do
      expect(subject).to be_valid
    end
  end

end