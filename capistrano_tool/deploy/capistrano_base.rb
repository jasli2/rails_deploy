unless Capistrano::Configuration.respond_to?(:instance)
  abort "This extension requires Capistrano 2"
end


namespace :deploy do
  namespace :user do

    desc "cause Passenger to initiate a restart"
    task :restart do
       run "touch #{current_path}/tmp/restart.txt"
    end
  
    desc "reload the database with seed data"
    task :seed do
      run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
    end

  end

end
