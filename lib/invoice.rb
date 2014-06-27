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
    @total = 0
    
    @items.each do |item|
      @total += item.price * item.quantity
    end

    if @country_code == 'BE' && valid_vat_number?
      vat = 0.21 * @total
    elsif ['IT','FR','NL','LU','DE'].include?(@country_code)
      if valid_vat_number?
        vat = 0
      else
        vat = 0.21 * @total
      end
    else
      vat = 0
    end

    @total += vat

    @total
  end

  private

  def valid_vat_number?
    !@vat_number.empty?
  end
end
