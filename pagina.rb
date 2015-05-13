
# TODO: doc
class Pagina

  attr_accessor :id         # id del proceso
  attr_accessor :index      # numero de pagina (indice de marco)
  attr_accessor :bitM       # bit de modificacion
  attr_accessor :timestamp  # tiempo de llegada

  # (void) initialize
  # 
  # inicializador del objeto pagina. Incluye el id de la pagina 
  # y el bit de modificacion, asi como el timestamp cuando se
  # crea el objeto en el tiempo actual
  # 
  def initialize(id, index)
    @id        = id
    @index     = index
    @bit_m     = false
    @timestamp = Time.now
  end

  # Hace que se modifique la pagina
  def modificar
    bit_m = true
  end

end
