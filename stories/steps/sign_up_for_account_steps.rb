steps_for(:signup) do
  Given "a blank slate" do
    @username = nil
    @password = nil
    @password_confirmation = nil
    @email = nil
    @firstname = nil
    @lastname = nil
    @address = nil
    @city = nil
    @state = nil
    @zip = nil
  end
  Given "a username '$username'" do |username|
    @username = username
  end
  
  Given "a password '$password'" do |password|
    @password = password
  end
  
  Given "a password_confirmation '$pass_conf'" do |pass_conf|
    @password_confirmation = pass_conf
  end
  
  Given "an email '$email'" do |email|
    @email = email
  end
  
  Given "a firstname '$firstname'" do |firstname|
    @firstname = firstname
  end
  
  Given "a lastname '$lastname'" do |lastname|
    @lastname = lastname
  end
  
  Given "an address '$address'" do |address|
    @address = address
  end
  
  Given "a city '$city'" do |city|
    @city = city
  end
  
  Given "a state '$state'" do |state|
    @state = state
  end
  
  Given "a zip '$zip'" do |zip|
    @zip = zip
  end

  Given "there is no uswer with this username" do
    User.find_by_login(@username).should be_nil
  end
  
  Given "a previous user with the name '$name'" do |name|
    @previous_user = User.create( :login => name,
                                  :password => "some_password",
                                  :password_confirmation => "some_password",
                                  :email => "email@address.com" )
  end
  
  When "the user creates an account with username, password, email, firstname, lastname, address, city, state, zip" do
    post "/users", :user => { :login => @username,
                                        :password => @password,
                                        :password_confirmation => @password,
                                        :email => @email },
                             :profile => { :firstname => @firstname,
                                           :lastname => @lastname,
                                           :address1 => @address,
                                           :city => @city,
                                           :state => @state,
                                           :zip => @zip}
  end
  
  When "the user creates an account with username, password, password_conf, email, firstname, lastname, address, city, state, zip" do
    post "/users", :user => { :login => @username,
                                        :password => @password,
                                        :password_confirmation => @password_confirmation,
                                        :email => @email },
                             :profile => { :firstname => @firstname,
                                           :lastname => @lastname,
                                           :address1 => @address,
                                           :city => @city,
                                           :state => @state,
                                           :zip => @zip}
  end
    
  Then "there should be a user named '$username'" do |username|
    User.find_by_login(username).should_not be_nil
  end
  
  Then "there should not be a user named '$username'" do |username|
    User.find_by_login(username).should be_nil
  end

  Then "there should be a profile for '$username'" do |username|
    user = User.find_by_login(username)
    user.should_not be_nil
    Profile.find_by_user_id(user.id).should_not be_nil
  end
  
  Then "should redirect to '$path'" do |path|
    response.should redirect_to(path)
  end
  
  Then "should return a '$code'" do |code|
    response.response_code.should == code.to_i
  end
  
  Then "the user '$name' should not have been updated" do |user|
    @previous_user.created_at.should == @previous_user.updated_at
  end
end