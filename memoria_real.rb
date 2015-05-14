require_relative "memoria"

# TODO: doc
class MemoriaReal < Memoria

  # Funcion que pone un proceso en la memoria real. Regresa
  # falso si ya no hay espacio
  def poner_proceso(id, bytes) # TODO: terminarlo
    # return false unless caben(bytes)
    marcos_a_poner = marcos_necesarios(bytes)
    marcos_puestos = []
    id_counter = 0

    @marcos.each_with_index do |marco, index|
      if esta_disponible?(marco) && marcos_a_poner > 0 
        @marcos[index] = Pagina.new(id, id_counter)
        @marcos_libres -= 1
        marcos_puestos.push(index)
        TablaDireccionamiento.insertar_real(id, id_counter, index)
        Administrador.aumentar_page_fault(id)
        marcos_a_poner -= 1
        id_counter += 1
      end
    end

    if @marcos_libres == 0 && marcos_a_poner > 0
      while marcos_a_poner > 0
        swap(id, id_counter)
        Administrador.aumentar_page_fault(id)
        marcos_a_poner -= 1
        id_counter += 1
      end
    end

    return marcos_puestos
  end
  
  def poner_pagina(id_proceso, indice_pagina)
    @marcos.each_with_index do |marco, index|
      if esta_disponible?(marco)
        @marcos[index] = Pagina.new(id, indice_pagina)          
        @marcos_libres -= 1
        TablaDireccionamiento.insertar(id, indice_pagina, index)        
      end 
    end
    swap(id_proceso, indice_pagina) 
  end


  

  # TODO: numero de swaps por proceso
  def swap(id_proceso, id_pagina_a_poner)
    # puts "entre con pid: #{id_proceso} y pagina #{id_pagina_a_poner}"
    p_info = Administrador.find_first_in
    TablaDireccionamiento.borrar_pagina(p_info["id_proceso"], 
                                        p_info["id_pagina"])
    @marcos.each_with_index do |marco, i|
      unless esta_disponible?(marco)
        if marco.pid == p_info["id_proceso"] && marco.index == p_info["id_pagina"]
          @marcos[i] = Pagina.new(id_proceso, id_pagina_a_poner)
          TablaDireccionamiento.insertar_real(id_proceso, id_pagina_a_poner, i)
          Administrador.agregar_swap_in(id_proceso)
          Administrador.agregar_swap_out(p_info["id_proceso"])
          return
        end
      end
    end
  end
end