class ResponseController < ApplicationController

  # GET /yes/1
  # GET /yes/1.json

  
  def yes
      @response = Response.find(params[:id])
      
      if (@response.yes == nil)
        @response.yes = 1
      else 
        @response.yes += 1
      end
      
      @response.save

      respond_to do |format|
        format.html { redirect_to question_path, notice: 'You have voted YES'  }
        format.json { head :no_content }
      end    
    
    
  end

  def no
    @response = Response.find(params[:id])
    
    if (@response.no == nil)
      @response.no = 1
    else 
      @response.no += 1
    end
    
    @response.save

    respond_to do |format|
      format.html { redirect_to question_path, notice: 'You have voted NO'  }
      format.json { head :no_content }
    end    
    
    
  end

  def count
  end
end
