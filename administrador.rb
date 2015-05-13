require_relative "memoria_real"
require_relative "memoria_virtual"

# TODO: doc
class Administrador

  def self.poner_en_memoria(id_proceso, bytes)
    # tratar de poner el proceso en memoria real
    # si no funciona:
    # => hacer swapping
    # si funciona:
    # => dejarlo ahi y copiarlo a virtual
  end

end