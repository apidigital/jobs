class ResumesController < ApplicationController
  skip_before_filter :admin_check, :only => [:index, :create, :destroy]
  # GET /resumes
  # GET /resumes.xml
  def index
    @resumes = Resume.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resumes }
    end
  end

  # GET /resumes/1
  # GET /resumes/1.xml
  def show
    resume = Resume.find(params[:id])
    # case File.extname(RAILS_ROOT + "/public" + resume.public_filename)
#     when ".doc"
#       @resume = Antiword.new(RAILS_ROOT + "/public" + resume.public_filename).to_s 
#     when ".txt"
#       @resume = File.open(RAILS_ROOT + "/public" + resume.public_filename).readlines.to_s
#     when ".rtf"
#       @resume = Unrtf.new(RAILS_ROOT + "/public" + resume.public_filename).to_s
#     end
    if params[:redbox]
	    render :partial => "resume", :object => resume
	  end
  end

  # GET /resumes/new
  # GET /resumes/new.xml
  def new
    @resume = Resume.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resume }
    end
  end

  # GET /resumes/1/edit
  def edit
    @resume = Resume.find(params[:id])
  end

  # POST /resumes
  # POST /resumes.xml
  def create
    @oldresume = Resume.find_by_user_id(current_user.id)
    @resume = Resume.new(params[:resume])
    @resume.user = current_user
    respond_to do |format|
      if @resume.save
        @oldresume.destroy if @oldresume
        flash[:notice] = 'Resume was successfully created.'
        format.html { redirect_to(profile_url(current_user.profile)) }
        format.xml  { render :xml => @resume, :status => :created, :location => @resume }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resumes/1
  # PUT /resumes/1.xml
  def update
    @resume = Resume.find(params[:id])

    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        flash[:notice] = 'Resume was successfully updated.'
        format.html { redirect_to(@resume) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.xml
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    @profile = context

    respond_to do |format|
      format.html { redirect_to(profiles_url) }
      format.xml  { head :ok }
    end
  end
end
