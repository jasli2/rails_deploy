unless Capistrano::Configuration.respond_to?(:instance)
  abort "This extension requires Capistrano 2"
end


namespace :deploy do
 desc "cause Passenger to initiate a restart"
 namespace :nginx do
   task :restart do
      kill_processes_matching "nginx"
      sleep 3
      kill_processes_matching "ruby"
      sleep 2
      sudo "service nginx restart"
   end
 end

 def kill_processes_matching(name)
    puts "kill #{name}"
      
    result = capture("echo `ps -e | grep #{name}`").strip
    unless result.empty?
      if name.eql?('ruby')
        value = capture("echo `ps -e | grep #{name} | grep -v grep | awk '{print $1}'`").strip
        temp = value.split(' ')
        puts temp.size
        unless temp.size <= 1
          index = temp.size - 2
          value = temp[0..index]
          array = value*' '
          run "#{sudo} kill #{array}"
        end
      else
        run "#{sudo} pkill #{name}"
      end
    end
 end

 after "deploy:nginx:restart", "deploy:resque:start"
end
