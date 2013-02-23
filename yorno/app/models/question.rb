class Question < ActiveRecord::Base
  belongs_to :user
  has_many :response
  
  attr_accessible :question_ans, :question_text, :user_id
end
