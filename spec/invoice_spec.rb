require 'minitest/autorun'
require_relative '../lib/invoice'

Item = Struct.new(:price, :quantity)

describe Invoice do

  let(:item1) { Item.new(20.0, 3) }
  let(:item2) { Item.new(15.0, 2) }
  let(:item3) { Item.new(100.0, 1) }

  let(:empty_invoice) { Invoice.new }
  let(:invoice) do
    tmp = Invoice.new
    tmp.add_item(item1)
    tmp.add_item(item2)
    tmp
  end

  it 'returns a zero total when empty' do
    assert_equal 0, empty_invoice.total
  end

  it 'returns a correct total' do
    assert_equal 90.0, invoice.total
  end

  it 'returns a correct total even after updating a previously added item' do
    assert_equal 90.0, invoice.total
    item2.quantity = 3
    assert_equal 105, invoice.total
  end

  it 'adds VAT when a valid Belgian VAT number is provided' do
    invoice = Invoice.new('BE', '123')
    invoice.add_item(item3)
    assert_equal 121, invoice.total
  end

  it 'doesnt add VAT when a valid French VAT number is provided' do
    invoice = Invoice.new('FR', '123')
    invoice.add_item(item3)
    assert_equal 100, invoice.total
  end

  it 'adds VAT when it is a private French person' do
    invoice = Invoice.new('FR')
    invoice.add_item(item3)
    assert_equal 121, invoice.total
  end

  it 'doesnt add VAT for a Japanese customer' do
    invoice = Invoice.new('JP')
    invoice.add_item(item3)
    assert_equal 100, invoice.total
  end
end