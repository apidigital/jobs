class MessagesController < ApplicationController
  def index
  	@messages = Message.all
  end
  
  def new
  	@message = Message.new
  	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end
  
  def create
  	@message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to messages_url }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
		@message = Message.find(params[:id])
  end
  
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to messages_url }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def success
  	@message = Message.find_by_title('success')
  	if @message.nil?
  		@message = Message.new
  		@message.title = 'success'
  		@message.content = 'This is a generic success message that should be changed!'
  		if @message.save!
	  		flash[:notice] = 'Success message was not found so it was created for you.'
	  		redirect_to messages_url
	  	else
	  		flash[:error] = 'Could not create a success message.'
	  	end
  	end
  end
end
