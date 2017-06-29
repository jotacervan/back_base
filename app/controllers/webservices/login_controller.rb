class Webservices::LoginController < WebservicesController
	
	# =============================================================
	# 					       SIGNIN METHOD
	# =============================================================
	api :POST, '/login/signin', "User sign in"
  	formats ['json']
  	param :cpf, String, :desc => "CPF ( 999.999.999-99 )", :required => true, :missing_message => lambda { "CPF ausente" }
  	param :password, String, :desc => "Senha", :required => true, :missing_message => lambda { "Senha ausente" }
  	error 401, "CPF não cadastrado em nosso sistema"
  	error 402, "Senha Invalida"
  	error 500, "Erro desconhecido"
  	example "Exemplo de retorno quando login for realizado com sucesso

  	{ 
  		:message => 'Login efetuado com Sucesso', 
  		:user => { 
  			:id => 192863tgv9146v4910y1b4, 
  			:name => 'Fulano de Tal', 
  			:udid => 123123, 
  			:status => 1, 
  			:picture => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989', 
  			:doc_front => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989', 
  			:doc_back => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989', 
  			:membership => '82736482', 
  			:civil_registry => '123123', 
  			:cpf => '999.999.999-99', 
  			:birthday => '99/99/1999', 
  			:marital_status => 'Casado', 
  			:occupation => 'Pedreiro', 
  			:address => 'Rua Teste 34, Pinheiro, São Paulo - SP', 
  			:education_level => 'Bacharel', 
  			:accepted_terms => true
  		} 
  	} "
  	example "Exemplo de retorno quando senha for incorreta

  	{ 
  		:message => 'Senha Invalida', 
  	} "
  	example "Exemplo de retorno quando CPF não for encontrado no sistema

  	{ 
  		:message => 'CPF não cadastrado em nosso sistema', 
  	} "
	def signin
		u = User.where(:cpf => params[:cpf]).first

		if !u.nil?
			if u.valid_password?(params[:password])
				sign_in u, :bypass => true
				render :json => { :message => 'Login efetuado com Sucesso', :user => User.mapuser(u) }
			else
				render :json => { :message => 'Senha Invalida' }, :status => 402
			end
		else
			render :json => { :message => 'CPF não cadastrado em nosso sistema' }, :status => 401
		end
	end


	# =============================================================
	# 					       SIGNUP METHOD
	# =============================================================
	api :POST, '/login/signup', "User sign up"
  	formats ['json']
  	param :name, String, :desc => 'Ex: Fulano de Tal', :required => true, :missing_message => lambda { "Nome é requerido" }
  	param :password, String, :desc => 'Senha', :required => true, :missing_message => lambda { "Senha é requerido" }
  	param :udid, String, :desc => 'UDID', :required => true, :missing_message => lambda { "UDID é requerido" }
  	param :membership, String, :desc => 'Filiação'
  	param :civil_registry, String, :desc => 'Registro Civil'
  	param :cpf, String, :desc => 'Ex: 999.999.999-99', :required => true, :missing_message => lambda { "CPF requerido" }
  	param :birthday, String, :desc => 'Ex: 05/04/1980'
  	param :marital_status, String, :desc => 'Ex: Casado, Solteiro, Divorciado, Viuvo'
  	param :occupation, String, :desc => 'Ex: Pedreiro'
  	param :address, String, :desc => 'Ex: Rua Janio 45, bloco A, São Paulo - SP'
  	param :education_level, String, :desc => 'Escolaridade'
  	param :accepted_terms, Boolean, :desc => 'Ex: true, false', :required => true, :missing_message => lambda { "Aceite os termos" }
  	error 403, "CPF já cadastrado em nosso sistema"
  	error 500, "Erro desconhecido"
  	example "Exemplo de retorno quando cadastro for realizado com sucesso 

  	{ 
  	 	:message => 'Cadastro realizado com Sucesso', 
  	  	:user => { 
  	  		:id => 192863tgv9146v4910y1b4, 
  	  		:name => 'Fulano de Tal', 
  	  		:udid => 123123, 
  	  		:status => 1,
  	  		:membership => '82736482',
  	  		:picture => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989', 
  			:doc_front => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989', 
  			:doc_back => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989', 
  	  		:civil_registry => '123123', 
  	  		:cpf => '999.999.999-99', 
  	  		:birthday => '99/99/1999', 
  	  		:marital_status => 'Casado', 
  	  		:occupation => 'Pedreiro',
  	  		:address => 'Rua Teste 34, Pinheiro, São Paulo - SP', 
  	  		:education_level => 'Bacharel', 
  	  		:accepted_terms => true 
  	  	}
  	} "
  	example "Exemplo de retorno quando CPF já tiver cadastro 

  	{ 
  		:message => 'CPF já cadastrado em nosso sistema' 
  	}"
	def signup
		u = User.where(:cpf => params[:cpf]).first

		if !u.nil?
			render :json => { :message => 'CPF já cadastrado em nosso sistema' }, :status => 403
		else
			u = User.new()
			u.name = params[:name] 
			u.membership = params[:membership]  
			u.civil_registry = params[:civil_registry] 
			u.cpf = params[:cpf] 
			u.birthday = params[:birthday]
			u.marital_status = params[:marital_status]
			u.occupation = params[:occupation]
			u.address = params[:address]
			u.education_level = params[:education_level]
			u.accepted_terms = params[:accepted_terms]
			u.password = params[:password]
			u.password_confirmation = params[:password]
			u.udid = params[:udid]
			u.status = 1
			u.save(validate: false)
			
			sign_in u, :bypass => true
			render :json => { :message => 'Cadastro Realizado com Sucesso', :user => User.mapuser(u) }
		end
	end


	# =============================================================
	# 					 UPDATE PHOTOS METHOD
	# =============================================================
	api :POST, '/login/update_photos', "Update Photos From User"
  	formats ['json']
  	param :id, String, :desc => 'Ex: 1234123hb14b1234i12,
 ID é encontrado no json de retorno param[:user][:id]', :required => true, :missing_message => lambda { "id é requerido" }
  	error 404, "Usuario não encontrado no sistema"
  	error 500, "Erro desconhecido"
  	example "Campos multpart para envio 

  	{ 
  		:picture => 'Multipart com a foto de perfil',
  		:doc_front => 'Multipart com a frente do documento',
  		:doc_back => 'Multipart com p verso do documento'
  	}"
  	example "Exemplo de retorno quando fotos forem inserida com sucesso 

  	{ 
  	 	:message => 'Fotos inseridas com sucesso', 
  	  	:user => { 
  	  		:id => 192863tgv9146v4910y1b4, 
  	  		:name => 'Fulano de Tal', 
  	  		:udid => 123123, 
  	  		:status => 1,
  	  		:picture => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989', 
  			:doc_front => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989', 
  			:doc_back => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989',
  	  		:membership => '82736482', 
  	  		:civil_registry => '123123', 
  	  		:cpf => '999.999.999-99', 
  	  		:birthday => '99/99/1999', 
  	  		:marital_status => 'Casado', 
  	  		:occupation => 'Pedreiro',
  	  		:address => 'Rua Teste 34, Pinheiro, São Paulo - SP', 
  	  		:education_level => 'Bacharel', 
  	  		:accepted_terms => true 
  	  	}
  	} "
  	example "Exemplo de retorno quando usuario não for encontrado 

  	{ 
  		:message => 'Usuario não encontrado no sistema' 
  	}"
	def update_photos
		u = User.find(params[:id]) rescue nil

		if !u.nil?
			render :json => { :message => 'Usuario não encontrado no sistema' }, :status => 404
		else
			u.picture = params[:picture] 
			u.doc_front = params[:doc_front]
			u.doc_back = params[:doc_back]
			u.status = 2
			u.save(validate: false)
			
			render :json => { :message => 'Fotos inseridas com sucesso', :user => User.mapuser(u) }
		end
	end


	# =============================================================
	# 					 UPDATE QUESTION METHOD
	# =============================================================
	api :POST, '/login/update_question', "Update Question From User"
  	formats ['json']
  	param :id, String, :desc => 'Ex: 1234123hb14b1234i12,
 ID é encontrado no json de retorno param[:user][:id]', :required => true, :missing_message => lambda { "id é requerido" }
 	param :security_question, String, :desc => 'Questão de Segurança', :required => true, :missing_message => lambda { "Questão de segurança é requerida" }
 	param :security_answer, String, :desc => 'Resposta de Segurança', :required => true, :missing_message => lambda { "Resposta de segurança é requerida" }
  	error 404, "Usuario não encontrado no sistema"
  	error 500, "Erro desconhecido"
  	example "Exemplo de retorno quando fotos forem inserida com sucesso 
  	
  	{ 
  	 	:message => 'Questão inserida com sucesso',
  	  	:user => { 
  	  		:id => 192863tgv9146v4910y1b4,
  	  		:name => 'Fulano de Tal',
  	  		:udid => 123123,
  	  		:status => 1,
  	  		:picture => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989',
  			  :doc_front => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989',
  			  :doc_back => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989',
  	  		:membership => '82736482',
  	  		:civil_registry => '123123',
  	  		:cpf => '999.999.999-99',
  	  		:birthday => '99/99/1999',
  	  		:marital_status => 'Casado', 
  	  		:occupation => 'Pedreiro',
  	  		:address => 'Rua Teste 34, Pinheiro, São Paulo - SP', 
  	  		:education_level => 'Bacharel',
  	  		:accepted_terms => true
  	  	}
  	}"
  	example "Exemplo de retorno quando usuario não for encontrado 

  	{ 
  		:message => 'Usuario não encontrado no sistema'
  	}"
	def update_question
		u = User.find(params[:id]) rescue nil

		if !u.nil?
			render :json => { :message => 'Usuario não encontrado no sistema' }, :status => 404
		else
			u.security_question = params[:security_question]
			u.security_answer = params[:security_answer]
			u.status = 3
			u.save(validate: false)
			
			render :json => { :message => 'Questão inserida com sucesso', :user => User.mapuser(u) }
		end
	end

end
