class Question < ActiveRecord::Base
  has_many :answers, :dependent => :destroy
  belongs_to :position
  acts_as_list :scope => :position, :column => "display_order"
end
