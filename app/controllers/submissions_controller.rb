class SubmissionsController < ApplicationController
  skip_before_filter :admin_check, :only => [:create, :update]
  # GET /submissions
  # GET /submissions.xml
  def index
    @submissions = Submission.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @submissions }
    end
  end

  # GET /submissions/1
  # GET /submissions/1.xml
  def show
    @submission = Submission.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @submission }
    end
  end

  # GET /submissions/new
  # GET /submissions/new.xml
  def new
    @submission = Submission.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @submission }
    end
  end

  # GET /submissions/1/edit
  def edit
    @submission = Submission.find(params[:id])
  end

  # POST /submissions
  # POST /submissions.xml
  def create
    @submission = Submission.new(params[:submission])

    respond_to do |format|
      if @submission.save
        flash[:notice] = 'Submission was successfully created.'
        format.html { redirect_to(@submission) }
        format.xml  { render :xml => @submission, :status => :created, :location => @submission }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @submission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /submissions/1
  # PUT /submissions/1.xml
  def update
    @submission = Submission.find(params[:id])
    @submission.consider_for_interview = true
    respond_to do |format|
      if @submission.update_attributes(params[:submission])
        flash[:notice] = 'Submission was successfully updated.'
        format.html { redirect_to(@submission) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @submission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.xml
  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy

    respond_to do |format|
      format.html { redirect_to(submissions_url) }
      format.xml  { head :ok }
    end
  end
  
  #Extra functionality.
  
  def mark
    @submission = Submission.find(params[:id])
    if @submission.checked_on?
      @submission.checked_on = false
    else
      @submission.checked_on = true
    end
    if @submission.save
      @saved = true
    else
      @saved = false
    end
    render :layout => false
  end
  
#	 	def approve_for_interview
#     @submission = Submission.find(params[:id])
#     @submission.consider_for_interview = true
#     @submission.save!
#   end
  
  def deny_for_interview
    @submission = Submission.find(params[:id])
    @submission.consider_for_interview = false
    @submission.save!
  end
  
  def appointment
  	@submission = Submission.find(params[:id])
  	render :partial => "appointment", :object => @submission
  end
end
