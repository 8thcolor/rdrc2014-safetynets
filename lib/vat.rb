module Vat
  def self.rate(country, vat_number = '')
    if country.belgium?
      return 0.21
    elsif country.europe?
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
