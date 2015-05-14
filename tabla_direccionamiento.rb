# TODO: doc
class TablaDireccionamiento

	#registro:
		# pid
		# index
	@registros_reales    = Array.new(256)
	@registros_virtuales = Array.new(512)
	
	def self.insertar_real(id_proceso, pagina, indice)
		@registros_reales[indice] = {"pid"=>id_proceso, "pagina"=>pagina}
	end
	
	def self.insertar_virtual(id_proceso, pagina, indice)
		@registros_virtuales[indice] = {"pid"=>id_proceso, "pagina"=>pagina}
	end
	
	def self.localizar(dir_virtual, id_proceso)
		pagina = (dir_virtual.to_f / 8).ceil
		@registros_reales.each do |registro|
			if registro["pid"] == id_proceso && registro["pagina"] == pagina
				return i * 8
			else
				return nil
			end
		end
	end

	def self.borradorP(id_proceso)
		#@registros_reales.each_with_index do |registro,i| 
		#	if registro["pid"] == id_proceso
		#		registros[i] == -1
		#	end
		#end
		#return lista
	end

	def self.borrar_pagina(id_proceso, id_pagina)
		@registros_reales.each_with_index do |registro, i|
			if registro["pid"] == id_proceso && registro["pagina"] == id_pagina
				@registros_reales[i] = nil
				return true
			end 
		end
	end

end