class Position < ActiveRecord::Base
  has_many :questions
  has_many :submissions, :dependent => :destroy
  has_many :users, :through => :submissions
  belongs_to :category
  
  named_scope :active, :conditions => { :active => true }

end
