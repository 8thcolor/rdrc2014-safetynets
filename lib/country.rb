class Country
  def initialize(code)
    @code = code
  end

  def belgium?
    @code == 'BE'
  end

  def europe?
    %w(IT FR NL LU DE).include? @code
  end
end