# TODO: doc
class TablaDireccionamiento

	#registro:
		# pid
		# index
	@registros = Array.new(256)
	
	def self.insertar(id_proceso, pagina, indice)
		@registros[indice] =  {"pid"=>id_proceso, "pagina"=>pagina}
	end
	
#	def	first_in()
#		lowest_time = Time.now
#		id = -1
#		@registros.each do |registro|
#			registro.
#		end
#	end
	
	def self.localizar(dir_virtual, id_proceso)
		pagina = (dir_virtual.to_f / 8).ceil
		@registros.each do |registro|
			if registro["pid"] == id_proceso && registro["pagina"] == pagina
				return i * 8
			else
				return nil
			end
		end
	end

	def self.borradorP(id_proceso)
		#@registros.each_with_index do |registro,i| 
		#	if registro["pid"] == id_proceso
		#		registros[i] == -1
		#	end
		#end
		#return lista
	end

	def self.borrar_pagina(id_proceso, id_pagina)
		@registros.each_with_index do |registro, i|
			if registro["pid"] == id_proceso && registro["pagina"] == id_pagina
				@registros[i] = nil
				return true
			end 
		end
	end

end