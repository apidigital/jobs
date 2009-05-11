class Category < ActiveRecord::Base
  has_many :positions, :dependent => :destroy

  def active_positions_count
    positions.active.count
  end
end
