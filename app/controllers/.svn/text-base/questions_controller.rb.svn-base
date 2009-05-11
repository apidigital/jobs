class QuestionsController < ApplicationController
layout 'layout'
skip_before_filter :admin_check, :only => [:index, :show]
before_filter :login_check, :only => [ :index, :new ]
#This after filter will remove the flash notice when it is displayed
#on the index page after you go to another page so it won't hang around.
after_filter :destroy_notice, :only => [ :index ]
  # GET /questions
  # GET /questions.xml
  def index
    @questions = context.questions.find(:all, :order => 'display_order')
    @answer = Answer.new
    @position = context
    @submission = Submission.find_by_user_id(current_user.id) if Submission.find_by_user_id_and_position_id(current_user, @position.id)
    if @submission
      flash[:notice] = 'You have already applied for this position.'
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
      format.js 
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new
    @position = context
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
    @position = context
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = context.questions.new(params[:question])
    
    respond_to do |format|
      if @question.save
        flash[:notice] = 'Question was successfully created.'
        format.html { redirect_to(position_path(@question.position)) }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Question was successfully updated.'
        format.html { redirect_to(position_question_path(@question.position)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(position_questions_path(@question.position)) }
      format.xml  { head :ok }
    end
  end
  
  def up
    @question = context.questions.find(params[:id])
    @question.move_higher
    if @question.save
      flash[:notice] = 'Question was successfully updated.'
      redirect_to(position_questions_path(@question.position))
    else
      flash[:notice] = 'There was an error updating question position.'
      redirect_to(position_questions_path(@question.position))
    end
  end

  def down
    @question = context.questions.find(params[:id])
    @question.move_lower
    if @question.save
      flash[:notice] = 'Question was successfully updated.'
      redirect_to(position_questions_path(@question.position))
    else
      flash[:notice] = 'There was an error updating question position.'
      redirect_to(position_questions_path(@question.position))
    end
  end
  
  def sort_questions
    params[:question_results].each_index do |i|
      item = Question.find(params[:question_results][i])
      item.display_order = i
      item.save
    end
    @position = Position.find_by_id(params[:id])
    @questions = @position.questions.find(:all, :order => 'display_order')    
    render :layout => false
  end
  
  def login_check
    unless logged_in?
      redirect_to('/login')
    end
  end
  
  def destroy_notice
    flash[:notice] = nil
  end
end
