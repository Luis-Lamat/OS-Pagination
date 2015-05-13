class Pagina

  attr_accessor :id         # id de la pagina actual
  attr_accessor :bitM       # bit de modificacion
  attr_accessor :timestamp  # tiempo de llegada
  attr_accessor :twin_id # marco de memoria virtual

  # (void) initialize
  # 
  # inicializa el objeto de pagina con 
  # los valores pasados
  # 
  def initialize(id, twin_id, bitM)
    @id        = id
    @twin_id   = twin_id
    @bitM      = bitM
    @timestamp = Time.now
  end

end
