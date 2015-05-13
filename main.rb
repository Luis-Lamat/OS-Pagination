require_relative "memoria"
require_relative "memoria_real"
require_relative "memoria_virtual"
require_relative "administrador"

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

# hash que tiene las acciones permitidas y como valor el tamaño maximo
# de su input, es decir, de sus caracteres de entrada
@acciones = {"P" => 3, "A" => 4, "L" => 2, "F" => 1, "E" => 1}

def get_input
  print "Ingrese los datos (Accion tamaño id): "
  gets.chomp
end

def size_restriction(char)
  
end

def parse_action(input)
  input = input.split
  return false unless @acciones.include? input[0]
  return false unless @acciones[input[0]] == input.size 
  true
end

#------------------------------------ MAIN ------------------------------------#

input = get_input

while input != "exit"

  accion = parse_action(input)

  puts accion

  # este metodo se encarga de ver la disponibilidad de los marcos
  # Administrador.asignar(id, num_marcos, accion)

  input = get_input
end