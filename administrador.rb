require_relative "memoria_real"
require_relative "memoria_virtual"

# TODO: doc
class Administrador

  # inicializacion de la memoria real
  @memoria_real = MemoriaReal.new({ 
    bytes_por_pagina: 8,
    numero_de_marcos: 256
  })

  # inicializacion de la memoria virtual
  @memoria_virtual = MemoriaVirtual.new({
    bytes_por_pagina: 8,
    numero_de_marcos: 512    
  })

  def self.poner_en_memoria(id_proceso, bytes)
    # tratar de poner el proceso en memoria real
    # si no funciona:
    # => hacer swapping (checar si se ha modificado)
    # si funciona:
    # => dejarlo ahi y copiarlo a virtual
  end

end