require_relative "pagina"
require_relative "tabla_direccionamiento"
require_relative "administrador"

class Memoria

  # constructor
  def initialize(hash)
    @marcos_libres = hash[:numero_de_marcos]
    @bytes_pagina  = hash[:bytes_por_pagina]
    @marcos        = Array.new(@marcos_libres, -1)
  end

  # getter de los marcos de memoria real/virtual
  def marcos
    return  @marcos 
  end

  private

    # Regresa la cantidad de marcos necesarios para un proceso
    # que ocupa 'n' bytes, dependiendo del tamaño de pagina 
    def marcos_necesarios(bytes)
      return (bytes.to_f / @bytes_pagina).ceil
    end

    # Regresa si la cantidad de bytes a poner caben con el total
    # de marcos disponibles, en este caso 256
    def caben(bytes, marcos_totales)
      return marcos_necesarios(bytes) <= marcos_totales
    end

    # regresa true si el marco esta disponible
    def esta_disponible?(marco)
      return marco == -1
    end

end