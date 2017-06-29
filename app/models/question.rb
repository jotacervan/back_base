class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :question, type: String

  def self.mapsQuestion
  	{ :question => self.question }
  end
end
