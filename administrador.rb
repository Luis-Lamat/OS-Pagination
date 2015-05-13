require_relative "memoria_real"
require_relative "memoria_virtual"

# TODO: doc, page faults
class Administrador

  def self.poner_en_memoria(id_proceso, bytes)
    # tratar de poner el proceso en memoria real
    # si no funciona:
    # => hacer swapping
    # si funciona:
    # => dejarlo ahi y copiarlo a virtual
  end
  
  def self.accesar(dir_virtual, id_proceso)
    # localizar donde esta la pagina que contiene
#    pagina = dir_virtual.to_i / 8
      direccion = TablaDireccionamiento.localizar(dir_virtual, id_proceso)
      return direccion unless direccion == -1
      return TablaDireccionamiento.actualizar(dir_virtual, id_proceso)     
    # esta en memoria secundaria?
    #    page fault
    #    poner_en_memoria
    
        
  end
end