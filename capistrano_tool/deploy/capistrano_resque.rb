
unless Capistrano::Configuration.respond_to?(:instance)
  abort "This extension requires Capistrano 2"
end

namespace :deploy do
  namespace :redis do
    desc <<-DESC
      start redis service, when web server first start
    DESC
    task :start, :except => { :no_release => true } do
     #run "nohup /usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf &) && sleep 1"
     job1 = Process.fork
     if job1.nil? then
      sudo "nohup /usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf"
     else
       Process.detach(job1)
     end
    end

    desc <<-DESC
      resstart redis service
    DESC
    task :restart, :except => { :no_release => true } do
      job1 = Process.fork
      if job1.nil? then
        kill_processes_matching "redis-server"
        sudo "nohup /usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf > /tmp/redis.log  2>&1"
      else
        Process.detach(job1)
      end

    end
  end

 def kill_processes_matching(name)
    sudo "ps -ef | grep #{name} | grep -v grep | awk '{print $2}' | xargs kill || echo 'no process with name #{name} found'"
 end

  namespace :resque do

    desc <<-DESC
      resque process should be started after redis is running
    DESC
    task :start, :except => { :no_release => true } do
     job1 = Process.fork
     if job1.nil? then
      run "cd #{current_path};RAILS_ENV=#{rails_env} nohup bundle exec rake resque:work QUEUE='*' VVERBOSE=1 > /tmp/resque.log  2>&1 "
     else
       Process.detach(job1)
     end
    end

    desc <<-DESC
      test sudo 
    DESC
    task :test_sudo do
      sudo "mkdir /poppop"
    end

  end
  after "deploy:restart",             "deploy:redis:start"
  after "deploy:redis:start",         "deploy:resque:start"
  after "deploy:user:restart",        "deploy:resque:start"

end
