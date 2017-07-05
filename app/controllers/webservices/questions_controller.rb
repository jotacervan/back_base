class Webservices::QuestionsController < WebservicesController

	# =============================================================
	# 					    GET QUESTION METHOD
	# =============================================================
	api :GET, '/questions/getQuestion', "Get Security Question"
	formats ['json']
	error 401, "Faça o login para continuar"
	error 402, "Usuário não encontrado"
	error 500, "Erro desconhecido"
	example "Exemplo de retorno
  	
	{ 
		:message => 'Questão carregada com sucesso',
		:questions => ['Pergunta 2?','Pergunta 2?', 'Pergunta 3?']
	}"
	example "Exemplo de retorno quando não estiver feito login

	{ 
		:message => 'Faça o login para continuar',
	}"
	example "Exemplo de retorno quando não forem encontradas perguntas

	{ 
		:message => 'Nenhuma questão encontrada',
	}"
	def getQuestion
		if current_user.nil?
			render :json => { :message => 'Usuário não encontrado' }, :status => 402
		else
			render :json => { :message => 'Questão carregada com sucesso', :questions => Question.mapQuestions(current_user.questions) }
		end
	end

	# =============================================================
	# 					  CHECK QUESTIONS METHOD
	# =============================================================
	api :POST, '/questions/checkQuestion', "Check Security Question"
	formats ['json']
	param :udid, String, :desc => 'UDID do novo celular'
	param :answers, Array, :desc => 'Array com as respostas do usuário'
	error 401, "Faça o login para continuar"
	error 402, "Usuário não encontrado"
	error 500, "Erro desconhecido"
	example "Exemplo de array de respostas para envio
  		
	{ 
		:answers => ['Resposta 1', 'Reposta 2', 'Resposta 3'],
	}"
	example "Exemplo de retorno
  		
	{ 
		:message => 'Questões verificadas com sucesso',
	}"
	example "Exemplo de retorno quando não estiver feito login

	{ 
		:message => 'Faça o login para continuar',
	}"
	example "Exemplo de retorno quando não forem encontradas respostas validas

	{ 
		:message => 'Respostas inválidas',
		:questions => ['Pergunta 1?', 'Pergunta 2?']
	}"
	def checkQuestion

		okay = 0
		ids = []

		params[:answers].each do |an|
			que = current_user.questions.where(:answer => an)
			if que.count > 0
				ids << que.first.id.to_s
				okay += 1
			end
		end

		if okay < 3
			questions = current_user.questions.where(:id.nin => ids)
			render :json => { :message => 'Respostas inválidas', :questions => Question.mapQuestions(questions) }, :status => 402
		else
			current_user.udid = params[:udid]
			if current_user.save(validate: false)
				render :json => { :message => 'Questões verificadas com sucesso' }, :status => 200
			else
				render :json => { :message => 'Erro ao atualizar udid' }, :status => 403
			end
		end
	end


end
