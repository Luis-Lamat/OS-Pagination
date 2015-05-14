begin_time = Time.now

require_relative "administrador"

# hash que tiene las acciones permitidas y como valor el tamaño maximo
# de su input, es decir, de sus caracteres de entrada
@acciones = {"P" => 3, "A" => 4, "L" => 2, "F" => 1, "E" => 1}
@metodos  = {"P" => "poner_en_memoria", "A" => "accesar", "L" => "borrar", 
             "F" => "hacer_reporte", "E" => "terminar"}


# Revisa un arreglo de strings y revisa que sean números
# válidos con una expresión regular
def are_integers(array)
  array.each do |element|
    return false unless /\A\d+\z/ === element
  end
  return true
end


# Recibe como parámetro el input del usuario y analiza lo que el sistema tiene 
# que hacer, ya sea: poner en memoria, accesar, borrar, hacer un reporte, o 
# terminar. Valida que el input esté correcto
def parse_action(input)
  input   = input.split
  letra   = input[0]
  return false unless @acciones.include? letra
  return false unless @acciones[letra] == input.size  

  accion = @metodos[letra]
  parametros = Hash.new  # este es el hash con los parámetros de la acción
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

# Se lee el archivo y se corren las funciones principales
input_file = File.new("prueba.txt", "r")
if input_file
  input_file.each_with_index do |line, i|
    # line[0] = '' if i == 0 # arregla bug
    puts line
    accion = parse_action(line.chomp)
    if !!accion
      # Esta línea manda a llamar el método adecuado de la clase administrador
      # dependiendo de la acción parseada por parse_action.
      # 'accion.values.first' con los parámetros de la función
      # Esto es considerado 'metaprogramación', cuando código hace código
      Administrador.send(accion.keys.first, accion.values.first)
    else
      puts "Error en linea #{i+1}..."
    end
  end
else
  puts "No encontré el archivo..."
end
input_file.close

finish_time = Time.now
puts "TIEMPO DE EJECUCION = #{(finish_time - begin_time)*1000} ms"
