class PagesController < ApplicationController
  def home
    @questions = Question.all
  end

  def about
  end
  
  def ask
    
  end
  
  def question
    @questions = Question.all
  end
end
