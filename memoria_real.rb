require_relative "memoria"

# TODO: doc
class MemoriaReal < Memoria

  # (bool) poner_proceso
  #
  # Funcion que pone un proceso en la memoria real. Regresa
  # falso si ya no hay espacio
  #
  def poner_proceso(id, bytes) # TODO: terminarlo
    return false unless caben(bytes)
    marcos_a_poner = marcos_necesarios(bytes)
    marcos_puestos = []    
    @marcos.each_with_index do |marco, index|      
      if esta_disponible?(marco) && marcos_a_poner > 0        
        @marcos[index] = Pagina.new(id, index)
        marcos_puestos.push(index)
        marcos_a_poner -= 1
      end
    end
    @marcos_libres -= marcos_a_poner
    return marcos_puestos
  end
end