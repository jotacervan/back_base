class Webservices::TorcidasController < WebservicesController
	# =============================================================
	# 					    GET TORCIDas METHOD
	# =============================================================
	api :GET, '/torcidas/getTorcidas', "Get all"
	formats ['json']
	param :id, String, :desc => 'ID do time', :required => true, :missing_message => lambda { "ID do time é requerido" }
	error 402, "Nenhum time encontrado"
	error 500, "Erro desconhecido"
	example "Exemplo de retorno

	{ 
		:message => 'Times carregados com sucesso',
		:questions => ''
	}"
	example "Exemplo de retorno quando não estiver feito login

	{ 
		:message => 'Faça o login para continuar',
	}"
	example "Exemplo de retorno quando não forem encontradas perguntas

	{ 	
		:message => 'Nenhuma torcida encontrada',
	}"
	def getTorcidas
		t = Torcida.where(:clube_id => params[:id])
		
		if t.blank?
			render :json => { :message => 'Nenhuma torcida encontrada' }, :status => 402
		else
			render :json => { :message => 'Torcidas carregadas com sucesso', :questions => Torcida.mapTorcida(t) }
		end
	end
end
