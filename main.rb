require_relative "administrador"

# hash que tiene las acciones permitidas y como valor el tamaño maximo
# de su input, es decir, de sus caracteres de entrada
@acciones = {"P" => 3, "A" => 4, "L" => 2, "F" => 1, "E" => 1}
@metodos  = {"P" => "poner_en_memoria", "A" => "accesar", "L" => "borrar", 
             "F" => "hacer_reporte", "E" => "terminar"}

def are_integers(array)
  array.each do |element|
    return false unless /\A\d+\z/ === element
  end
  return true
end

def parse_action(input)
  input   = input.split
  letra   = input[0]
  return false unless @acciones.include? letra
  return false unless @acciones[letra] == input.size  

  accion = @metodos[letra]
  parametros = Hash.new   
  case letra
    when "P"
      return false unless are_integers([input[1], input[2]])
      parametros = {"bytes" => input[1], "id_proceso"=> input[2]}
    when "A"
      return false unless are_integers([input[1], input[2], input[3]])
      parametros = {"direccion" => input[1], "id_proceso"=> input[2], 
                    "bitM"=> input[3]}
    when "L"
      return false unless are_integers([input[1]])
      parametros = {"id_proceso"=> input[1]}
    when "E"
      puts "Exit"
  end
  datos = Hash.new
  datos[accion] = parametros
  return datos
end

#------------------------------------ MAIN ------------------------------------#

input_file = File.new("prueba.txt", "r")
if input_file
  input_file.each_with_index do |line, i|
    # line[0] = '' if i == 0 # arregla bug
    accion = parse_action(line.chomp)
    if !!accion
      Administrador.send(accion.keys.first, accion.values.first)
    else
      puts "Error en linea #{i+1}..."
    end
  end
else
  puts "No encontré el archivo..."
end
input_file.close
