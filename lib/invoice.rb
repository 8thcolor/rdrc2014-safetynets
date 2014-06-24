class Invoice
  def initialize(country_code = '', vat_number = '')
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def total
    total = 0
    
    @items.each do |item|
      total += item.price * item.quantity
    end

    total
  end
end
