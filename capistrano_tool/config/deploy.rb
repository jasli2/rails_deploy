require "bundler/capistrano"

load "deploy/capistrano_database_yml"
load "deploy/capistrano_base"
load "deploy/capistrano_resque"
load "deploy/capistrano_nginx"

set :user, "XXX"
set :password, "XXXX"
set :domain, "XXXX"
set :application, "evolution"
#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user

set :repository,  "git://github.com/jasli2/evolution.git"
set :deploy_to, "/home/deployer/evolution_deploy/evolution"


role :web, domain                         # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
ssh_options[:forward_agent] = true


set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :sudo_prompt, "XXXXX"
set :rails_env, "production"

default_run_options[:pty] = true

#namespace :deploy do
#  desc "cause Passenger to initiate a restart"
#  task :restart do
#    run "touch #{current_path}/tmp/restart.txt"
#  end
#  desc "reload the database with seed data"
#  task :seed do
#     run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
#  end
#end
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
