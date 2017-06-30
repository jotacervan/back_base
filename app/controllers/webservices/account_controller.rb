class Webservices::AccountController < WebservicesController

	# =============================================================
	#                         GET ABOUT METHOD
	# =============================================================
	api :GET, '/account/getAbout', "Get About User"
	formats ['json']
	error 401, "Faça o login para continuar"
	error 402, "Usuário não encontrado"
	error 500, "Erro desconhecido"
	example "Exemplo de retorno

	{ 
	  :message => 'Informações carregadas com sucesso', 
	  :user => {
	    :id => 192863tgv9146v4910y1b4, 
	    :name => 'Fulano de Tal', 
	    :udid => 123123, 
	    :status => 1,
	    :status_message => 'Aguardando aprovacão da torcida!',
	    :picture => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989',
	    :doc_front => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989',
	    :doc_back => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989',
	    :membership => '82736482',
	    :civil_registry => '123123',
	    :cpf => '999.999.999-99', 
	    :birthday => '99/99/1999', 
	    :marital_status => 'Casado', 
	    :occupation => 'Pedreiro',
	    :cep => '13413-324', 
        :state => 'SP',
        :city => 'São Paulo',
        :neighborhood => 'Pinheiros',
        :street => 'Rua teste',
        :number => '123',
        :complement => 'apto 20',
	    :education_level => 'Bacharel', 
	    :time_name => 'Nome do Time',
        :torcida_name => 'Nome da Torcida',
	    :time_logo => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989', 
        :torcida_logo => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989', 
	    :accepted_terms => true,
	    :payment => true
	  }
	}"
	example "Exemplo de retorno quando não estiver feito login

	{ 
	:message => 'Faça o login para continuar',
	}"
	example "Exemplo de retorno quando não forem encontradas perguntas

	{ 
	:message => 'Nenhuma informação disponível',
	}"
	def getAbout
		if current_user.nil?
		  render :json => { :message => 'Nenhuma informação disponível' }, :status => 402
		else
		  render :json => { :message => 'Informações carregadas com sucesso', :user => User.mapuser(current_user) }
		end
	end

end
