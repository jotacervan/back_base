class Webservices::TimesController < WebservicesController
	# =============================================================
	# 					    GET TIMES METHOD
	# =============================================================
	api :GET, '/times/getTimes', "Get all"
	formats ['json']
	error 402, "Nenhum time encontrado"
	error 500, "Erro desconhecido"
	example "Exemplo de retorno
	
	{ 
		:message => 'Times carregados com sucesso',
		:times => [
			{ :id => '12381763782618s78', :name => 'Time tal', :picture => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989' },
			{ :id => '12381763782618s78', :name => 'Time tal', :picture => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989' }
		]
	}"
	example "Exemplo de retorno quando não estiver feito login

	{ 
		:message => 'Faça o login para continuar',
	}"
	example "Exemplo de retorno quando não forem encontradas perguntas

	{ 
		:message => 'Nenhum time encontrado',
	}"
	def getTimes
		c = Clube.all
		
		if c.nil?
			render :json => { :message => 'Nenhum time encontrado' }, :status => 402
		else
			render :json => { :message => 'Times carregados com sucesso', :times => Clube.mapClube(c) }
		end
	end
end
