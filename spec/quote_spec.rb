require 'minitest/autorun'
require_relative '../lib/quote'

describe Quote do

  let(:empty_quote) { Quote.new }
  let(:quote) { Quote.new(100.0) }

  it 'returns a zero total when empty' do
    assert_equal 0, empty_quote.total
  end

  it 'returns a correct total' do
    assert_equal 100.0, quote.total
  end

  it 'adds VAT when a valid Belgian VAT number is provided' do
    quote = Quote.new(100.0, 'BE', '123')
    assert_equal 121, quote.total
  end

  it 'doesnt add VAT when a valid French VAT number is provided' do
    quote = Quote.new(100.0, 'FR', '123')
    assert_equal 100, quote.total
  end

  it 'adds VAT when it is a private French person' do
    quote = Quote.new(100.0, 'FR')
    assert_equal 121, quote.total
  end

  it 'doesnt add VAT for a Japanese customer' do
    quote = Quote.new(100.0, 'JP')
    assert_equal 100, quote.total
  end
end