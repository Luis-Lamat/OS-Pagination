require_relative "memoria_real"
require_relative "memoria_virtual"
require_relative "presenter"
require_relative "tabla_direccionamiento"


# TODO: doc, page faults
class Administrador

  @page_faults = Hash.new(0)
  @swap_ins    = Hash.new(0)
  @swap_outs   = Hash.new(0)

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

  def self.poner_en_memoria(opciones)
    bytes      = opciones["bytes"].to_i
    id_proceso = opciones["id_proceso"].to_i
    respuesta  = @memoria_real.poner_proceso(id_proceso, bytes)
    respuesta2 = @memoria_virtual.poner_proceso(id_proceso, bytes)
    # print @memoria_real.inspect
    # print @memoria_virtual.inspect
  end
  
  def self.accesar(opciones)
    # localizar donde esta la pagina que contiene
#     pagina = (dir_virtual.to_f / 8).floor
    dir_virtual = opciones["direccion"].to_i
    id_proceso  = opciones["id_proceso"].to_i
    pagina      = (dir_virtual.to_f / 8).floor 
    direccion   = TablaDireccionamiento.localizar(dir_virtual, id_proceso)
    unless direccion == nil
      return direccion
    end
    aumentar_page_fault(id_proceso)
    direccion_virtual = TablaDireccionamiento.localizar(id_proceso, pagina)
    @memoria_real.poner_pagina(id_proceso, pagina)
    direccion_real =  TablaDireccionamiento.localizar(dir_virtual, id_proceso)     
    # TablaDireccionamiento.print()
    # puts "direccion real: #{direccion_real}, direccion s: #{direccion_virtual}"
  end

  def self.hacer_reporte(opciones)
    Presenter.hacer_reporte
  end

  def self.borrar(opciones)
    id_proceso = opciones["id_proceso"]
    @memoria_virtual.limpiar(id_proceso)
    @memoria_real.limpiar(id_proceso)
    TablaDireccionamiento.limpiar(id_proceso)
    TablaDireccionamiento.print()
    puts "@@@ Memorial Real"
    @memoria_real.print
    puts "@@@ Memorial Virtual"
    @memoria_virtual.print
  end


  def self.terminar(opciones)
    # TODO: hacer
    # print "terminar"
    # TablaDireccionamiento.print()
    puts "page faults: #{@page_faults.inspect}"
  end
  
  def self.find_first_in
  	lowest_time = Time.now
		id = -1
    pagina_a_reemplazar = {}
    @memoria_real.marcos.each_with_index do |marco, i|
      unless marco == -1
        pagina = marco
        if pagina.timestamp < lowest_time
          lowest_time = pagina.timestamp
          id_proceso = pagina.pid
          id_pagina = i
          pagina_a_reemplazar = {"id_proceso" => id_proceso,
                                 "id_pagina"  => id_pagina}
        end
      end
    end
    return pagina_a_reemplazar
  end

  def self.agregar_swap_in(id_proceso)
    @swap_ins[id_proceso] += 1
  end

  def self.agregar_swap_out(id_proceso)
    @swap_outs[id_proceso] += 1
  end

  def self.get_swap_ins
    @swap_ins
  end

  def self.get_swap_outs
    @swap_outs
  end

  def self.get_page_faults
    @page_faults
  end

  def self.aumentar_page_fault(id_proceso)
    @page_faults[id_proceso] += 1    
  end
end