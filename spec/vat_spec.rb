require 'minitest/autorun'
require_relative '../lib/vat'

describe Vat do
  it 'returns a rate of 0.21 for valid Belgian VAT number' do
    assert_equal 0.21, Vat::rate('BE', '123')
  end

  it 'returns a rate of 0.21 for Belgians without VAT number' do
    assert_equal 0.21, Vat::rate('BE')
  end

  it 'returns a zero rate for valid French VAT number' do
    assert_equal 0.0, Vat::rate('FR', '123')
  end

  it 'returns a rate of 0.21 for Frenchies without VAT number' do
    assert_equal 0.21, Vat::rate('FR')
  end

  it 'returns a zero rate for Japanese' do
    assert_equal 0.0, Vat::rate('JP')
  end
end