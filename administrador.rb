require_relative "memoria_real"
require_relative "memoria_virtual"
require_relative "presenter"
require_relative "tabla_direccionamiento"


# TODO: doc, page faults
class Administrador

  # variables globales para la clase
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

  # pone en memoria virtual y real el proceso que llegó, si no cabe completo,
  # imprime ese error
  def self.poner_en_memoria(opciones)
    bytes      = opciones["bytes"].to_i
    id_proceso = opciones["id_proceso"].to_i

    # si el proceso es demasiado grande, manda un error
    unless @memoria_real.caben(bytes, 256)
      puts "El proceso completo no cabe en memoria real..."
      return false 
    end

    # continua poniendo en memoria si el proceso si cabe
    respuesta  = @memoria_real.poner_proceso(id_proceso, bytes)
    respuesta2 = @memoria_virtual.poner_proceso(id_proceso, bytes)
  end
  
  # accion para accesar al marco de página de un proceso
  # si existe su dirección, la regresa, si no, crea un page fault y 
  # lo carga en memoria real
  def self.accesar(opciones)
    dir_virtual = opciones["direccion"].to_i
    id_proceso  = opciones["id_proceso"].to_i
    pagina      = (dir_virtual.to_f / 8).floor 
    direccion   = TablaDireccionamiento.localizar(dir_virtual, id_proceso)
    return direccion unless direccion == nil      
    aumentar_page_fault(id_proceso)
    direccion_virtual = TablaDireccionamiento.localizar(id_proceso, pagina)
    @memoria_real.poner_pagina(id_proceso, pagina)
    direccion_real = TablaDireccionamiento.localizar(dir_virtual, id_proceso)
  end

  # accion de 'F' para imprimir el reporte final
  def self.hacer_reporte(opciones)
    Presenter.hacer_reporte
  end

  def self.borrar(opciones)

    id_proceso = opciones["id_proceso"]
    #busca y borra proceso de memoria virtual
    @memoria_virtual.marcos.each_with_index do |marco, i|
      @memoria_virtual.marcos[i] =-1 if marco == id_proceso
    end
    #busca y borra proceso de memoria real
    @memoria_real.marcos.each do |marco|
      @memoria_virtual.marcos=-1 if marco == id_proceso
    end

    #manda a llamar un metodo de la clase tablaS
    TablaDireccionamiento.borradorP(id_proceso)

  end

  # accion de 'E' de terminar el programa
  def self.terminar(opciones)
    exit
  end
  
  # Encuentra el primer proceso que entró a memoria real
  # para intercambiarlo en el swap (política FCFS)
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

  # aumenta los swap_ins de ese proceso
  def self.agregar_swap_in(id_proceso)
    @swap_ins[id_proceso] += 1
  end

  # aumenta los swap_outs de ese proceso
  def self.agregar_swap_out(id_proceso)
    @swap_outs[id_proceso] += 1
  end

  # getter de swap_ins totales
  def self.get_swap_ins
    @swap_ins
  end

  # getter de swap_outs totales
  def self.get_swap_outs
    @swap_outs
  end

  # getter de page_faults totales
  def self.get_page_faults
    @page_faults
  end
  
  # aumenta los page_faults de ese proceso
  def self.aumentar_page_fault(id_proceso)
    @page_faults[id_proceso] += 1    
  end

end