class CreateSubmissions < ActiveRecord::Migration
  def self.up
    create_table :submissions do |t|
      t.integer :user_id
      t.integer :position_id
      t.integer :checked_on

      t.timestamps
    end
  end

  def self.down
    drop_table :submissions
  end
end
