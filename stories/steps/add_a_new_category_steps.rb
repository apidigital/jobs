steps_for(:add_a_new_category) do 
  Given "a administrative user" do
    @user = User.create( :login => 'admin', 
                         :password => 'admin', 
                         :password_confirmiation => 'admin',
                         :email => 'admin@admin.com', 
                         :admin => true )
  end
  
  Given "a non-administrative user" do
    @user = User.create( :login => 'not_admin', 
                         :password => 'not_admin', 
                         :password_confirmiation => 'non-admin',
                         :email => 'admin@admin.com', 
                         :admin => false )
  end
  
  Given "a category named '$name'" do |name|
    @name = name
  end
  
  Given "there is no category with this name" do
    Category.find_by_name(@name).should be_nil
  end
  
  When "the admin submits a new category name" do
    current_user = User.authenticate(@user.login, 'admin')
    post '/categories', :category => { :name => @name }
  end
  
  When "the user submits a new category name" do
    current_user = User.authenticate(@user.login, 'non-admin')
    post '/categories', :category => { :name => @name }
  end
  
  Then "redirect to category path" do
    category = Category.find_by_name(@name)
    category.should_not be_nil
    response.should redirect_to(category_path(category)) 
  end
  
  Then "there should be a category with name '$name'" do |name|
    Category.find_by_name(name).should_not be_nil
  end
  
  Then "there should not be a category with the name '$name'" do |name|
    Category.find_by_name(name).should be_nil
  end
  
  Then "Redirect to $path" do |path|
    response.should redirect_to(path)
  end
  
end