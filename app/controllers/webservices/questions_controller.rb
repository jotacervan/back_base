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
end
