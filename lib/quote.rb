class Quote
  def initialize(total = 0, country_code = '', vat_number = '')
    @total = total
    @country_code = country_code
    @vat_number = vat_number
  end

  def total
    if @country_code == 'BE'
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

    @total + vat
  end

  private

  def valid_vat_number?
    !@vat_number.empty?
  end
end
