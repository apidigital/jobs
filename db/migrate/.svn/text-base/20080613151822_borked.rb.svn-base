class Borked < ActiveRecord::Migration
  def self.up
    rename_column :questions, :order, :display_order
  end

  def self.down
    rename_column :questions, :display_order, :order
  end
end
