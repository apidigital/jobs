class Question < ActiveRecord::Base
  has_many :answers, :dependent => :destroy
  belongs_to :position
  acts_as_list :scope => :position, :column => "display_order"
  validates_presence_of :content
  #attr_accessor :should_destroy
  
  #def should_destroy?
  #	should_destroy.to_i == 1
  #end
end
