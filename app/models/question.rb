class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :question, type: String
  field :answer, type: String
  
  belongs_to :user, optional: :true

  def self.mapQuestions(q)
  	arr = []
  	q.each do |qu|
  		arr <<  qu.question 
  	end
  	arr
  end
end
