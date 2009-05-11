class Forattachfu < ActiveRecord::Migration
    def self.up
      create_table :files do |t|
        t.column :content_type, :string
        t.column :filename, :string    
        t.column :size, :integer
        t.column :user_id, :integer
        t.timestamps
      end
    end

    def self.down
      drop_table :files
    end
  end