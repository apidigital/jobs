class AddNotifiedToSubmissions < ActiveRecord::Migration
  def self.up
  	add_column :submissions, :notified, :boolean
  end

  def self.down
  	remove_column :submissions, :notified
  end
end
