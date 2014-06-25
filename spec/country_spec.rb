require 'minitest/autorun'
require_relative '../lib/country'

describe Country do
  let(:belgium) { Country.new('BE') }
  let(:france) { Country.new('FR') }
  let(:japan) { Country.new('JP') }

  it 'is belgium when it is' do
    assert belgium.belgium?
  end

  it 'is europe when it is' do
    assert france.europe?
  end

  it 'is not belgium nor europe when it is not' do
    refute japan.belgium?
    refute japan.europe?
  end
end