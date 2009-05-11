require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Category do
  before(:each) do
    @valid_attributes = {
      :name => "Category Name"
    }
  end

  it "should create a new instance given valid attributes" do
    Category.create!(@valid_attributes)
    Category.find_by_name(@valid_attributes[:name]).should_not be_nil
  end
  
  it "should remove all positions when destroyed" do
    category = Category.create!(@valid_attributes)
    position = category.positions.create(:name => "new position", :description => "new position")
    id = position.id
    category.destroy
    Position.find_by_id(id).should be_nil
  end
end
