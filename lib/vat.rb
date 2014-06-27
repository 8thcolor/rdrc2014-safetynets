module Vat
  def self.rate(country_code = '', vat_number = '')
    if country_code == 'BE'
      return 0.21
    elsif %w(IT FR NL LU DE).include?(country_code)
      if is_valid?(vat_number)
        return 0
      else
        return 0.21
      end
    else
      return 0
    end
  end

  private

  def self.is_valid?(vat_number)
    !vat_number.empty?
  end
end
