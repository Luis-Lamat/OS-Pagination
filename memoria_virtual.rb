require_relative "memoria"

# TODO: doc
class MemoriaVirtual < Memoria

  # Funcion que pone un proceso en la memoria virtual.
  def poner_proceso(id, bytes)
    marcos_a_poner = marcos_necesarios(bytes)
    marcos_puestos = []
    id_counter = 0

    @marcos.each_with_index do |marco, index|
      if esta_disponible?(marco) && marcos_a_poner > 0
        @marcos[index] = Pagina.new(id, id_counter)
        @marcos_libres -= 1
        marcos_puestos.push(index)
        TablaDireccionamiento.insertar_virtual(id, id_counter, index)
        marcos_a_poner -= 1
        id_counter += 1
      end
    end

    return marcos_puestos
  end
end