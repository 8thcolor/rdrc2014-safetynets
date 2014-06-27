require 'vat'

class Quote
  def initialize(total = 0, country_code = '', vat_number = '')
    @total = total
    @country_code = country_code
    @vat_number = vat_number
  end

  def total
    vat = Vat::rate(@country_code, @vat_number) * @total

    @total + vat
  end

  private

  def valid_vat_number?
    !@vat_number.empty?
  end
end
