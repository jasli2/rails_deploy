unless Capistrano::Configuration.respond_to?(:instance)
  abort "This extension requires Capistrano 2"
end


namespace :deploy do
  namespace :local do
    desc "deploy local web app, restart app"
    task :restart do
      run "touch #{current_path}/tmp/restart.txt"
    end
  end

  namespace :user do
    desc "cause Passenger to initiate a restart"
    task :restart do
       run "cd #{current_path}; git checkout master; git branch -D deploy; git pull"
       run "cd #{current_path}; git checkout -b deploy"
       run "touch #{current_path}/tmp/restart.txt"
    end
  
    desc "reload the database with seed data"
    task :seed do
      run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
    end

  end
end
