class Question < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :question_ans, :question_text
end
