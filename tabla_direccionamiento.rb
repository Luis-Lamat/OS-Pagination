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
	
#	def	first_in()
#		lowest_time = Time.now
#		id = -1
#		@registros.each do |registro|
#			registro.
#		end
#	end
	
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

end