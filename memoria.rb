require_relative "pagina"

# TODO: doc
class Memoria

  def initialize(hash)
    @marcos_libres = hash[:numero_de_marcos]
    @bytes_pagina  = hash[:bytes_por_pagina]
    @marcos        = Array.new(@marcos_libres, -1)
  end

  private

    # (int) marcos_necesarios
    # 
    # Regresa la cantidad de marcos necesarios para un proceso
    # que ocupa 'n' bytes, dependiendo del tamaño de pagina
    # 
    def marcos_necesarios(bytes)
      return (bytes.to_f / @bytes_pagina).ceil
    end

    def caben(bytes)
      return marcos_necesarios(bytes) < @marcos_libres
    end

    def esta_disponible?(marco)
      return marco != -1
    end

end