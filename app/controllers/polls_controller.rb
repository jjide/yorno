class PollsController < ApplicationController

	def vote_yes
		@poll = Poll.find(params[:id])
		@poll.yeses += 1
		@poll.save

		cookies[:max_id] = @poll.id
		respond_to do |format|
			format.html { redirect_to(polls_url, :notice => 'Thank you for voting.') }
		end
	end

	def vote_no
		@poll = Poll.find(params[:id])
		@poll.nos += 1
		@poll.save
		cookies[:max_id] = @poll.id
		respond_to do |format|
			format.html { redirect_to(polls_url, :notice => 'Thank you for voting.') }
		end
	end

	# GET /polls
	# GET /polls.xml
	def index
		max_id = cookies[:max_id]
		max_id = max_id.nil? ? 0 : Integer(max_id)

		@answer_me = Poll.where("id > ?", max_id).first
		if @answer_me 			
			@category = Category.where("id = ?", @answer_me.category_id).first
		end
		@polls = Poll.where("id <= ?", max_id)

		respond_to do |format|
			format.html # index.html.erb
			format.xml { render :xml => @polls }
		end
	end

	# GET /polls/admin
	def admin
		max_id = cookies[:max_id]
		max_id = max_id.nil? ? 0 : Integer(max_id)

		@answer_me = Poll.where("id > ?", max_id).first
		@polls = Poll.all

		respond_to do |format|
			format.html # index.html.erb
		end
	end

	# GET /polls/1
	# GET /polls/1.xml
	def show
		@poll = Poll.find(params[:id])
		@category = Category.find(@poll.category_id)

		respond_to do |format|
			format.html # show.html.erb
			format.xml { render :xml => @poll }
		end
	end

	# GET /polls/new
	# GET /polls/new.xml
	def new
		@poll = Poll.new
		@categories = Category.find :all

		respond_to do |format|
			format.html # new.html.erb
			format.xml { render :xml => @poll }
		end
	end

	# GET /polls/1/edit
	def edit
		@poll = Poll.find(params[:id])
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
				format.html { redirect_to :action=> "index" }
				format.xml { render :xml => @poll, :status => :created, :location => @poll }
			else
				format.html { render :action => "new" }
				format.xml { render :xml => @poll.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /polls/1
	# PUT /polls/1.xml
	def update
		@poll = Poll.find(params[:id])

		respond_to do |format|
			if @poll.update_attributes(params[:poll])
				format.html { redirect_to(@poll, :notice => 'Poll was successfully updated.') }
				format.xml { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml { render :xml => @poll.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /polls/1
	# DELETE /polls/1.xml
	def destroy
		@poll = Poll.find(params[:id])
		@poll.destroy

		respond_to do |format|
			format.html { redirect_to(polls_url) }
			format.xml { head :ok }
		end
	end

	def upload_file
		if(params[:upload])
			render :text => "File has been uploaded successfully"
		else
			respond_to do |format|
				format.html # index.html.erb
			end
		end
	end
end
