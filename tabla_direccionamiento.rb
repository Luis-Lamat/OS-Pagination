# TODO: doc
class TablaDireccionamiento

	#registro:
		# pid
		# index
	
	def	initialize()
		@registros = Array.new(256)
	end
	
	def insertar(id_proceso, pagina, indice)
		@registros[a] =  {"pid"=>id_proceso, "pagina"=>pagina}
	end
	
	def self.localizar(dir_virtual, id_proceso)
		pagina = dir_virtual.to_i / 8
		@registros.each do |registro|
			if registro["pid"] == id_proceso && registro["index"] == pagina
				return i * 8
			else
				return nil
			end
		end
	end
	#busca proceso
	def self.borradorP(id_proceso)
		#@registros.each_with_index do |registro,i| 
		#	if registro["pid"] == id_proceso
		#		registros[i] == -1
		#	end
		#end
		#return lista
	end

end