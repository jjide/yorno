class Response < ActiveRecord::Base
  belongs_to :question
  
  attr_accessible :count, :no, :yes
  
  
end
