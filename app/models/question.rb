class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :question, type: String

  def self.mapQuestions(q)
  	arr = []
  	q.each do |qu|
  		arr <<  qu.question 
  	end
  	arr
  end
end
