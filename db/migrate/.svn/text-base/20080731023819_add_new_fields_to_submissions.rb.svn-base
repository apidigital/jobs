class AddNewFieldsToSubmissions < ActiveRecord::Migration
  def self.up
    add_column :submissions, :consider_for_interview, :boolean
    add_column :submissions, :interview_scheduled, :datetime
    add_column :submissions, :interview_accepted, :boolean
    add_column :submissions, :position_offered, :boolean
    add_column :submissions, :start_date, :datetime
  end

  def self.down
    remove_column :submissions, :start_date
    remove_column :submissions, :position_offered
    remove_column :submissions, :interview_accepted
    remove_column :submissions, :interview_scheduled
    remove_column :submissions, :consider_for_interview
  end
end
