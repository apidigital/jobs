require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Profile do
  before(:each) do
    @user = User.create(:login => "foobar", :password => "foobar", :password_confirmation => "foobar", :email => "foo@bar.com")
    @first = "Foo"
    @last = "Bar"
    @address1 = "111 Foo Bar"
    @address2 = "Apt2"
    @city = "Foo"
    @state = "Bar"
    @zip = "34323"
  end

  it "should be valid" do
    @profile = Profile.new( :firstname => @first, 
                            :lastname => @last, 
                            :address1 => @address1, 
                            :address2 => @address2,
                            :city => @city, 
                            :state => @state, 
                            :zip => @zip )
                          
    @profile.user = @user
    @profile.save
    @profile.should be_valid
  end
  
  it "should error on no first name" do
    @profile = Profile.new( :firstname => nil,
                            :lastname => @last,
                            :address1 => @address1,
                            :address2 => @address2,
                            :city => @city,
                            :state => @state,
                            :zip => @zip )
    @profile.user = @user
    @profile.save.should_not be_true
    
  end
  
  it "should error on no last name" do
    @profile = Profile.new( :firstname => @first,
                            :lastname => nil,
                            :address1 => @address1,
                            :address2 => @address2,
                            :city => @city,
                            :state => @state,
                            :zip => @zip )
    @profile.user = @user
    @profile.save.should_not be_true
    
  end
  
  it "should error on no address1" do
    @profile = Profile.new( :firstname => @first,
                            :lastname => @last,
                            :address1 => nil,
                            :address2 => @address2,
                            :city => @city,
                            :state => @state,
                            :zip => @zip )
    @profile.user = @user
    @profile.save.should_not be_true
    
  end
  
  it "should not error on no address2" do
    @profile = Profile.new( :firstname => @first,
                            :lastname => @last,
                            :address1 => @address1,
                            :address2 => nil,
                            :city => @city,
                            :state => @state,
                            :zip => @zip )
    @profile.user = @user
    @profile.save.should be_true
  end
  
  it "should error on no city" do
    @profile = Profile.new( :firstname => @first,
                            :lastname => @last,
                            :address1 => @address1,
                            :address2 => @address2,
                            :city => nil,
                            :state => @state,
                            :zip => @zip )
    @profile.user = @user
    @profile.save.should_not be_true
  end
  
  it "should error on no state" do
    @profile = Profile.new( :firstname => @first,
                            :lastname => @last,
                            :address1 => @address1,
                            :address2 => @address2,
                            :city => @city,
                            :state => nil,
                            :zip => @zip )
    @profile.user = @user
    @profile.save.should_not be_true
  end
  
  it "should error on no zip" do
    @profile = Profile.new( :firstname => @first,
                            :lastname => @last,
                            :address1 => @address1,
                            :address2 => @address2,
                            :city => @city,
                            :state => @state,
                            :zip => nil )
    @profile.user = @user
    @profile.save.should_not be_true
  end
                            
end