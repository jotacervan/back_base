class Webservices::QuestionsController < WebservicesController

	# =============================================================
	# 					    GET QUESTION METHOD
	# =============================================================
	api :GET, '/questions/getQuestions', "Get Security Questions"
	formats ['json']
	error 401, "Faça o login para continuar"
	error 402, "Nenhuma questão encontrada"
	error 500, "Erro desconhecido"
	example "Exemplo de retorno
  
	{ 
		:message => 'Questões carregadas com sucesso',
		:questions => [
			'pergunta 1?',
			'pergunta 2?',
			'pergunta 3?',
		]
	}"
	example "Exemplo de retorno quando não estiver feito login

	{ 
		:message => 'Faça o login para continuar',
	}"
	example "Exemplo de retorno quando não forem encontradas perguntas

	{ 
		:message => 'Nenhuma questão encontrada',
	}"
	def getQuestions
		q = Question.all

		if q.nil?
			render :json => { :message => 'Nenhuma questão encontrada' }, :status => 402
		else
			render :json => { :message => 'Questões carregadas com sucesso', :questions => Question.mapQuestions(q) }
		end
	end
end
