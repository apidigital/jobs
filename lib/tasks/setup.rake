desc "Bootstrap database"
task :bootstrap => :environment do

  # Create the initial user account, it will also be the account that sends 
  # out emails and such
  
  user = User.create(:login => "Admin", 
              :password_confirmation => 'changeme', 
              :password => "changeme",
              :email => "jobs@apid.com")
  profile = Profile.create( :firstname => "Administrator", 
                            :lastname => "Administrator",
                            :address1 => "Administrator",
                            :city => "Administrator",
                            :state => "Administrator", 
                            :zip => 55555,
                            :admin => true)
  user.profile = profile
  user.save!
  profile.save!
end
