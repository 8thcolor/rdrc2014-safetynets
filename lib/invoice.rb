require 'vat'

class Invoice
  def initialize(country_code = '', vat_number = '')
    @items = []
    @total = 0
    @country_code = country_code
    @vat_number = vat_number
  end

  def add_item(item)
    @items << item
  end

  def total
    @total = calculate_subtotal

    vat = Vat::rate(@country_code, @vat_number) * @total

    @total += vat

    @total
  end

  private

  def calculate_subtotal
    @items.reduce(0) do |total, item|
      total + item.price * item.quantity
    end
  end
end
