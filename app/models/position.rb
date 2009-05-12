class Position < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  has_many :submissions, :dependent => :destroy
  has_many :users, :through => :submissions
  belongs_to :category
  named_scope :active, :conditions => { :active => true }
  after_update :save_questions
  validates_associated :questions
  
  def new_question_attributes=(question_attributes)
  	question_attributes.each do |attributes|
  		questions.build(attributes)
  	end
  end
  
  def existing_question_attributes=(question_attributes)
  	questions.reject(&:new_record?).each do |question|
  		attributes = question_attributes[question.id.to_s]
  		if attributes
  			question.attributes = attributes
  		else
  			questions.delete(question)
  		end
  	end
  end
  			
  
  def save_questions
  	questions.each do |question|
  		question.save(false)
  	end
  end
end
