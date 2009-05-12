class ResourceManagementController < ApplicationController
  def index
    @interviews = Submission.scheduled_interviews
    @applicants = User.applicants
    @questionnaires = Submission.questionnaire_step
  end
  
  def questionnaire
    @positions = Position.find(:all)
    @denied_submissions = Submission.denied_questionnaires
  end
  
  def interview
    @positions = Position.find(:all)
    @scheduled_interviews = Submission.scheduled_interviews
  end
  
  def approve_for_interview
    @submission = Submission.find(params[:id])
    @submission.consider_for_interview = true
    @submission.save!
  end
  
  def deny_for_interview
    @submission = Submission.find(params[:id])
    @submission.consider_for_interview = false
    @submission.save!
  end
end
