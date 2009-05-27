class PositionsController < ApplicationController
  skip_before_filter :admin_check, :only => [:show]
  # GET /positions
  # GET /positions.xml
  def index
  	@categories = Category.find(:all)
    if params[:query]
	    @positions = current_user && current_user.admin? ? Position.find(:all, :conditions => ["category_id = :query", {:query => params[:query]}]) : Position.active
		else
		  @positions = current_user && current_user.admin? ? Position.find(:all, :order => 'created_at DESC') : Position.active
		end
		
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @positions }
    end
  end

  # GET /positions/1
  # GET /positions/1.xml
  def show
    @position = Position.find(params[:id])
    unless @position.active? || (current_user && current_user.admin?)
      flash[:notice] = "This position is not yet avaliable, please try again later."
      redirect_to "/"
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @position }
      end
    end
  end

  # GET /positions/new
  # GET /positions/new.xml
  def new
    @position = Position.new
    @position.questions.build
    @categories = Category.find(:all)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @position }
    end
  end

  # GET /positions/1/edit
  def edit
    @position = Position.find(params[:id])
    @categories = Category.find(:all)
    @questions = @position.questions.find(:all, :order => 'display_order')
  end

  # POST /positions
  # POST /positions.xml
  def create
    @position = Position.new(params[:position])
    @categories = Category.find(:all)

    respond_to do |format|
      if @position.save
        flash[:notice] = 'Position was successfully created.'
        format.html { redirect_to(@position) }
        format.xml  { render :xml => @position, :status => :created, :location => @position }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @position.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /positions/1
  # PUT /positions/1.xml
  def update
  	params[:position][:existing_question_attributes] ||= {}
  	
    @position = Position.find(params[:id])
    respond_to do |format|
      if @position.update_attributes(params[:position])
        flash[:notice] = 'Position was successfully updated.'
        format.html { redirect_to(@position) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @position.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1
  # DELETE /positions/1.xml
  def destroy
    @position = Position.find(params[:id])
    @position.destroy

    respond_to do |format|
      format.html { redirect_to(positions_url) }
      format.xml  { head :ok }
    end
  end
  
  # Custom content
  
  def deactivate
  	@position = Position.find(params[:id])
  	@position.active = false
  	@position.save!
  end
  
  def activate
  	@position = Position.find(params[:id])
  	@position.active = true
  	@position.save!
  end
end
