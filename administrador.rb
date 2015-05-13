require_relative "memoria"
require_relative "pagina"

# TODO Doc
class Administrador

  def poner_en_memoria(process_id)
    
  end

  def self.esta_disponible?(num_pagina)
    memoria[num_pagina]
  end

end