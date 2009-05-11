class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :dayphone
      t.string :eveningphone
      t.integer :user_id
      t.integer :admin

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
