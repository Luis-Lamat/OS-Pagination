# TODO Doc
class Memoria

  def initialize
    @marcos_reales    = Array.new(256, -1)
    @marcos_virtuales = Array.new(512, -1)
  end

  def real(index)
    @marcos_reales[index]
  end

  def virtual(index)
    @marcos_reales[index]
  end

end