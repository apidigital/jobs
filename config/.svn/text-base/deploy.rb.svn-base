set :application, "jobs.apid.com"
set :repository,  "svn://svn.apid.com/jobs/trunk"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/usr/local/rails/jobs"
set :deploy_via, :export

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "63.238.52.91"
role :web, "63.238.52.91"
role :db,  "63.238.52.91", :primary => true


before "deploy:setup", :db
after "deploy:update_code", "db:symlink"


namespace :db do 
  desc "Create database yaml in shared path"
  task :default do
    db_config = ERB.new <<-EOF
    base: &base
      adapter: mysql
      host: 63.238.52.93
      username: #{ENV['DBUSER']}
      password: #{ENV['DBPASS']}
      
    production:
      database: jobs_production
      <<: *base
      
    development:
      database: jobs_development
      <<: *base
      
    test:
      database: jobs_test
      <<: *base
    
    EOF
    
    run "mkdir -p #{shared_path}/config"
    put db_config.result, "#{shared_path}/config/database.yml"
  end
  
  desc "make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

task :after_update_code, :roles => :app do
  %w{files}.each do |share|
    run "rm -rf #{release_path}/public/#{share}"
    run "mkdir -p #{shared_path}/system/#{share}"
    run "ln -nfs #{shared_path}/system/#{share} #{release_path}/public/#{share}"
  end
end