class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :position
  has_many :questions
  
  named_scope :checked, :conditions => { :checked_on => true }
  named_scope :unchecked, :conditions => { :checked_on => false }
  
  named_scope :questionnaire_step, 
              :conditions => { :consider_for_interview => nil, 
                               :interview_scheduled => nil, 
                               :position_offered => nil, 
                               :start_date => nil },
              :order => " created_at "
  named_scope :interview_step, :conditions => { :consider_for_interview => true, :position_offered => nil, :start_date => nil, :interview_scheduled => nil }
  named_scope :offering_step, :conditions => { :position_offered => true, :start_date => nil }
  named_scope :starting_step, :conditions => ["start_date != ? and start_date > ?", nil, lambda { Time.now } ] 
  named_scope :denied_questionnaires, :conditions =>  { :consider_for_interview => false }
  named_scope :scheduled_interviews, :conditions => ["consider_for_interview = ? and interview_scheduled is not null", true], :order => 'interview_scheduled'
  
  def step
    return "questionnaire"
  end
  
  def conflicts
    Submission.find(:all, :conditions => ["interview_scheduled BETWEEN ? AND ? AND id != ?", interview_scheduled.ago(29.minutes), interview_scheduled.since(29.minutes), self.id])
  end
  
  def self.notify_denied_submissions
  	@submissions = Submission.denied_questionnaires
  	if @submissions
	  	@submissions.each do |submission|
	  		submission.notified = true
	  		DenialMailer.deliver_denied(submission)
	  		submission.save!
	  	end
	  end
  end
end
