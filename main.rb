require_relative "administrador"

# hash que tiene las acciones permitidas y como valor el tamaño maximo
# de su input, es decir, de sus caracteres de entrada
@acciones = {"P" => 3, "A" => 4, "L" => 2, "F" => 1, "E" => 1}
@metodos = {"P" => "poner_en_memoria", "A" => "asignar", "L" => "borrar", 
            "F" => "fin", "E" => "exit"}

def get_input
  print "Ingrese los datos (Accion tamaño id): "
  gets.chomp
end

def parse_action(input)
  input = input.split
  return false unless @acciones.include? input[0]
  return false unless @acciones[input[0]] == input.size
  accion = @metodos[input[0]]
  parametros = Hash.new   
  case input[0]
    when "P"
     parametros = {"n" => input[1], "p"=> input[2]}
    when "A"
     parametros = {"d" => input[1], "m"=> input[2], "p"=> input[3]}
    when "L"
     parametros = {"p"=> input[1]}
    else
    puts "Exit"
  end
  datos = Hash.new
  datos[accion] = parametros
  return datos
end

#------------------------------------ MAIN ------------------------------------#

input = get_input

while input != "salir"

  accion = parse_action(input)  
  #  Administrador.send(accion)  
  # este metodo se encarga de ver la disponibilidad de los marcos
  # Administrador.asignar(id, num_marcos, accion)
  puts accion

  input = get_input
end