class Webservices::LoginController < WebservicesController
	
	api :POST, '/login/signin', "User sign in"
  	formats ['json']
  	param :cpf, String, :desc => "CPF ( 999.999.999-99 )", :required => true, :missing_message => lambda { "CPF ausente" }
  	param :password, String, :desc => "Senha", :required => true, :missing_message => lambda { "Senha ausente" }
  	error 401, "CPF não cadastrado em nosso sistema"
  	error 402, "Senha Invalida"
  	error 500, "Erro desconhecido"
  	example " { :name => 'Fulano de Tal', :picture => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989', :membership => '82736482', :civil_registry => '123123', :cpf => '999.999.999-99', :birthday => '99/99/1999', :marital_status => 'Casado', :occupation => 'Pedreiro', :address => 'Rua Teste 34, Pinheiro, São Paulo - SP', :education_level => 'Bacharel', :accepted_terms => true } "
	def signin
		u = User.where(:cpf => params[:cpf]).first

		if !u.nil?
			if u.valid_password?(params[:password])
				sign_in u, :bypass => true
				render :json => User.mapuser(u)
			else
				render :json => { :message => 'Senha Invalida' }, :status => 402
			end
		else
			render :json => { :message => 'CPF não cadastrado em nosso sistema' }, :status => 401
		end
	end


	api :POST, '/login/signup', "User sign up"
  	formats ['json']
  	param :name, String, :desc => 'Ex: Fulano de Tal', :required => true, :missing_message => lambda { "Nome é requerido" }
  	param :membership, String, :desc => 'Ex: 24523523'
  	param :civil_registry, String, :desc => 'Ex: 45342252'
  	param :cpf, String, :desc => 'Ex: 999.999.999-99', :required => true, :missing_message => lambda { "CPF requerido" }
  	param :birthday, String, :desc => 'Ex: 05/04/1980'
  	param :marital_status, String, :desc => 'Ex: Casado, Solteiro, Divorciado, Viuvo'
  	param :occupation, String, :desc => 'Ex: Pedreiro'
  	param :address, String, :desc => 'Ex: Rua Janio 45, bloco A, São Paulo - SP'
  	param :education_level, String, :desc => 'Ex: Ensino Superior Completo, Incompleto'
  	param :accepted_terms, Boolean, :desc => 'Aceita os termos de uso', :required => true, :missing_message => lambda { "Aceite os termos" }
  	param :picture, String, :desc => 'Multipart Image'
  	error 403, "CPF já cadastrado em nosso sistema"
  	error 500, "Erro desconhecido"
  	example " { :name => 'Fulano de Tal', :picture => 'http://s3.amazonaws.com/TorcidaLegal/pictures/59484ad9a3f9f30004362d6b/original.png?1497909989', :membership => '82736482', :civil_registry => '123123', :cpf => '999.999.999-99', :birthday => '99/99/1999', :marital_status => 'Casado', :occupation => 'Pedreiro', :address => 'Rua Teste 34, Pinheiro, São Paulo - SP', :education_level => 'Bacharel', :accepted_terms => true } "
	def signup
		u = User.where(:cpf => params[:cpf], :user_type => 'User').first

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
			u.picture = params[:picture]
			u.password = '12345678'
			u.password_confirmation = '12345678'
			u.save(validate: false)
			
			render :json => User.mapuser(u)
		end
	end


end
