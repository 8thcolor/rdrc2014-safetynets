require 'minitest/autorun'
require_relative '../lib/vat'

Country = Struct.new(:belgium?, :europe?)

describe Vat do
  let(:belgium) { Country.new(true, false) }
  let(:france) { Country.new(false, true) }
  let(:japan) { Country.new(false, false) }

  it 'returns a rate of 0.21 for valid Belgian VAT number' do
    assert_equal 0.21, Vat::rate(belgium, '123')
  end

  it 'returns a rate of 0.21 for Belgians without VAT number' do
    assert_equal 0.21, Vat::rate(belgium)
  end

  it 'returns a zero rate for valid French VAT number' do
    assert_equal 0.0, Vat::rate(france, '123')
  end

  it 'returns a rate of 0.21 for Frenchies without VAT number' do
    assert_equal 0.21, Vat::rate(france)
  end

  it 'returns a zero rate for Japanese' do
    assert_equal 0.0, Vat::rate(japan)
  end
end