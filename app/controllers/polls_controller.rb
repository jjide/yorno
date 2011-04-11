class PollsController < ApplicationController

	def vote
		@poll = Poll.find(params[:id])

    if('YES' == params[:commit])
      @poll.yeses += 1
    else
      @poll.nos += 1
    end
		
		@poll.save
    flash[:question] = @poll.question
    flash[:category_id] = @poll.category_id
    flash[:photo_1_url] = @poll.photo.url(:large).ends_with?("missing.png") ? nil :  @poll.photo.url(:large)
    flash[:photo_2_url] = @poll.photo2.url(:large).ends_with?("missing.png") ? nil : @poll.photo2.url(:large)
    flash[:yeses] = @poll.yeses
    flash[:nos] = @poll.nos


    random_poll      = Poll.first(:offset => (Poll.count * rand).to_i)
    random_poll_url = "#{polls_url}/#{random_poll.id}"

		respond_to do |format|
			format.html { redirect_to(random_poll_url, :notice => 'Thank you for voting.') }
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
    @selected_tab =0 
    @answer_me = Poll.find params[:id]
    @category = Category.find @answer_me.category_id

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @answer_me }
    end
  end


	# GET /polls/admin
#	def admin
#    max_id = get_max_id()
#
#		@answer_me = Poll.where("id > ?", max_id).first
#		@polls = Poll.order("id asc").all
#
#		respond_to do |format|
#			format.html # index.html.erb
#		end
#	end

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
		puts "Do I even get into create?????"
    @poll = Poll.new(params[:poll])
		@poll.yeses=0
		@poll.nos=0
		@poll.category_id=params[:category_id]

		puts "About to respond_to"

    respond_to do |format|
      puts "About to save #{@poll.to_s}"
			unless @poll.valid?
        puts @poll.errors.full_messages
      end
      
      if @poll.save
		    puts "Just saved"
        flash[:new_id ] = @poll.id
				format.html { redirect_to :action=> "index" }
				format.js
			else
				puts "didn't save"
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

    @answer_me = Poll.first(:offset => (Poll.count * rand).to_i)
    if @answer_me
      @category = Category.find @answer_me.category_id
    end

  end

end
