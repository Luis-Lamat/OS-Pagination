require_relative "memoria_real"
require_relative "memoria_virtual"
require_relative "tabla_direccionamiento"


# TODO: doc, page faults
class Administrador

  @page_faults = Hash.new(0)

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
    # tratar de poner el proceso en memoria real
    # si no funciona:
    # => hacer swapping (checar si se ha modificado)
    # si funciona:
    # => dejarlo ahi y copiarlo a virtual
    bytes      = opciones["bytes"].to_i
    id_proceso = opciones["id_proceso"].to_i

    respuesta  = @memoria_real.poner_proceso(id_proceso, bytes)
    # if respuesta.kind_of? Array
    #   @page_faults[id_proceso] = respuesta.size
    # else
    #   # poner algo mas
    # end
    print @memoria_real.inspect
  end
  
  def self.accesar(opciones)
    # localizar donde esta la pagina que contiene
    # pagina = dir_virtual.to_i / 8
    dir_virtual = opciones["direccion"]
    id_proceso  = opciones["id_proceso"]
    direccion   = TablaDireccionamiento.localizar(dir_virtual, id_proceso)
    return direccion unless direccion == -1
    return TablaDireccionamiento.actualizar(dir_virtual, id_proceso)
    page_faults[id_proceso] += 1
    # esta en memoria secundaria?
    #    page fault
    #    poner_en_memoria
    return TablaDireccionamiento.actualizar(dir_virtual, id_proceso)     
  end

  def self.hacer_reporte(opciones)
    id_proceso = opciones["id_proceso"]

    # TODO: hacer
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

  def self.accesar(opciones)
    # TODO: hacer
  end

  def self.terminar(opciones)
    # TODO: hacer
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

end