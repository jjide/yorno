class PollsController < ApplicationController

	def vote
		@poll = Poll.find(params[:id])

    if('YES' == params[:commit])
      @poll.yeses += 1
    else
      @poll.nos += 1
    end
		
		@poll.save
		cookies[:max_id] = {:value => @poll.id, :expires => Time.now + 2.months}
    flash[:just_voted] = @poll

		respond_to do |format|
			format.html { redirect_to(polls_url, :notice => 'Thank you for voting.') }
    end
	end


	# GET /polls
	# GET /polls.xml
	def index
    prepare_for_application_html
    @selected_tab = 0;
    

		respond_to do |format|
			format.html # index.html.erb
		end
	end

  # GET /polls/1
  # GET /polls/1.xml
  def show
    prepare_for_application_html
    @selected_tab = -1
    @poll = Poll.find params[:id]
    @category = Category.find @poll.category_id

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @poll }
    end
  end


  def already_voted
    prepare_for_application_html
    @selected_tab = -1

    @polls = Poll.where("id <= ?", get_max_id).order("id asc")
  end

	# GET /polls/admin
	def admin
    max_id = get_max_id()
		
		@answer_me = Poll.where("id > ?", max_id).first
		@polls = Poll.order("id asc").all

		respond_to do |format|
			format.html # index.html.erb
		end
	end

#	# GET /polls/new
#	# GET /polls/new.xml
#	def new
#    prepare_for_application_html
#
#		respond_to do |format|
#			format.html # new.html.erb
#			format.xml { render :xml => @poll }
#		end
#	end

	# GET /polls/1/edit
	def edit
		flash[:error] = "Nice try. No Editing allowed"
	end

	# POST /polls
	# POST /polls.xml
	def create
		@poll = Poll.new(params[:poll])
		@poll.yeses=0
		@poll.nos=0
		@poll.category_id=params[:category_id]

		respond_to do |format|
			if @poll.save
				flash[:new_id ] = @poll.id
				format.html { redirect_to :action=> "index" }
				format.js
			else
				format.html { render :action => "new" }
				format.js
			end
		end
	end

	# PUT /polls/1
	# PUT /polls/1.xml
	def update
		flash[:error] = "Nice try. No updating allowed."
	end

#	# DELETE /polls/1
#	# DELETE /polls/1.xml
#	def destroy
#		@poll = Poll.find(params[:id])
#		@poll.destroy
#
#		respond_to do |format|
#			format.html { redirect_to(polls_url) }
#			format.xml { head :ok }
#		end
#	end

  private
  def prepare_for_application_html
    @poll = Poll.new
    @categories = Category.all    
    max_id = cookies[:max_id]
    max_id = max_id.nil? ? 0 : Integer(max_id)

    @answer_me = Poll.where("id > ?", max_id).order("id asc").first
    if @answer_me
      @category = Category.find @answer_me.category_id
    end

  end

  def get_max_id
    max_id = cookies[:max_id]
    max_id = max_id.nil? ? 0 : Integer(max_id)
    max_id
  end
end
