class ChangeQuestionsContentToText < ActiveRecord::Migration
  def self.up
  	change_column :questions, :content, :text
  end

  def self.down
  	change_column :questions, :content, :string
  end
end
