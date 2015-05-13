# TODO: doc
class TablaDireccionamiento

	#registro:
		# pid
		# index
	
	def	initialize()
		@registros = Array.new(256)		
	end
	
	def insertar(id_proceso, pagina, indice)
		@registros[indice] =  {"pid"=>id_proceso, "pagina"=>pagina}
	end
	
	def self.localizar(dir_virtual, id_proceso)
#		pagina = dir_virtual.to_i / 8
		for(i in 0..255)
			if @registros[i]["pid"] == id_proceso && @registros[i]["index"] == pagina
			return i * 8   
			else
			return nil
		end
	end
end