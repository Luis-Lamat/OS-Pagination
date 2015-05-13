
# TODO: doc
class MemoriaReal < Memoria

  # (bool) poner_proceso
  #
  # Funcion que pone un proceso en la memoria real. Regresa
  # falso si ya no hay espacio
  #
  def poner_proceso(id, bytes) # TODO: terminarlo
    return false unless caben bytes
    @marcos.each_with_index do |marco, index|
      marco = Pagina.new(id, index) if esta_disponible?(marco)
    end
    @marcos_libres -= marcos_necesarios(bytes)
  end

end