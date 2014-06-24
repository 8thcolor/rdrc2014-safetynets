require 'minitest/autorun'
require_relative '../lib/item'

describe Item do
  let(:price) { 20.0 }
  let(:quantity) { 5 }
  subject { Item.new(price, quantity)}

  it 'has a price' do
    assert_equal price, subject.price
  end

  it 'has a quantity' do
    assert_equal quantity, subject.quantity
  end

  it 'could update the price' do
    price = 10.0
    subject.price = price
    assert_equal price, subject.price
  end

  it 'could update the quantity' do
    quantity = 10.0
    subject.quantity = quantity
    assert_equal quantity, subject.quantity
  end
end