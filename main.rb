# require_relative "memoria_real"
# require_relative "memoria_virtual"
# require_relative "administrar"

marcos_disponibles = 256

def get_input
  print "Ingrese los datos (Accion tamaño id): "
  gets.chomp()
end

input = get_input

while input != "exit"
  
  accion = input[0]
  bytes  = input[1]
  id     = input[2]

  # sacando el numero de marcos
  num_marcos = ( bytes.to_f / 8 ).ceil
  p num_marcos
  # este metodo se encarga de ver la disponibilidad de los marcos
  # Administrador.asignar(id, num_marcos, accion)

end