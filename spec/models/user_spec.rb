require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  
  it "should have a login" do
    user = User.create(:login => "foobar", :password => "foobar", :password_confirmation => "foobar", :email => "foo@bar.com")
    user.errors.should be_blank
  end
  
  it "should have at least 3 characters in his login" do
    user = User.create(:login => "fo")
    user.errors.on(:login).should == "is too short (minimum is 3 characters)"
  end
  
  it "should have at least 4 characters in password" do
    user = User.create( :login => "foobar", 
                        :password => "foo", 
                        :password_confirmation => "foo", 
                        :email => "foo@bar")
    user.errors.on(:password).should == "is too short (minimum is 4 characters)"
  end
  
  it "should have an email address" do
    user = User.create( :login => "foobar",
                        :password => "foobar",
                        :password_confirmation => "foobar",
                        :email => nil)
    user.errors.on(:email).should_not be_blank
  end
  
  it "should have matching password and password confirmation" do
    user = User.create( :login => "foobar",
                        :password => "foobar",
                        :password_confirmation => "barfoo",
                        :email => "foo@bar" )
    user.errors.on(:password).should_not be_blank
  end
  
  it "should remove profile when it is deleted" do
    user = User.create( :login => "foobar",
                        :password => "foobar",
                        :password_confirmation => "foobar",
                        :email => "foo@bar" )
    user.errors.should be_blank
    profile = Profile.new( :firstname => "first",
                           :lastname => "last",
                           :address1 => "address",
                           :city => "city",
                           :state => "state",
                           :zip => "zip" )
    profile.user = user
    profile.save
    profile.errors.should be_blank
    profile_id = profile.id
    user.destroy
    Profile.find_all_by_id(profile_id).should be_blank
  end
  
  it "should allow a user to login" do
    user = User.create(:login => "foobar", :password => "foobar", :password_confirmation => "foobar", :email => "foo@bar.com")
    user.errors.should be_blank
    auth = User.authenticate("foobar", "foobar")
    auth.should == user
  end
  
  it "should remember a user if they want to be remembered" do
    user = User.create(:login => "foobar", :password => "foobar", :password_confirmation => "foobar", :email => "foo@bar.com")
    user.errors.should be_blank
    user.remember_me
    user.remember_token?.should be_true
  end
  
  it "should forget a user when they log out" do
    user = User.create(:login => "foobar", :password => "foobar", :password_confirmation => "foobar", :email => "foo@bar.com")
    user.errors.should be_blank
    user.remember_me
    user.remember_token?.should be_true
    user.forget_me
    user.remember_token?.should_not be_true
  end
  
end
