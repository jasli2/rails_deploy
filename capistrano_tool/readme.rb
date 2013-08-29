# Category::    evolution deploy tool
# Package::     Capistrano
# Author::      Long Li <hutuxiansheng@gmail.com>
# Copyright::   2013-08-29 The Authors

# == Requirements
# befor use this script you should install ruby1.9.3 rails3.2 and so on
# or use SUPER_TOOL(install rails requirements environment ) on  remote server
#
#
# == Usage
# you should modify some options to adapt different server
#
# Example for localhost: (My PC)
#    1、config/deploy.rb 
#       1） set :user, "long"     --- remote server ssh login user name
#       2)  set :password, " "    --- ssh password
#       3)  set :domain, "ubuntu" --- remote server IP address
#       4)  set :sudo_prompt, " " --- user password, to get remote server root permission
#    2、deploy/capistrano_database_yml.rb 
#       1)  SQLUSERNAME="root"    --- remote server SQL user name
#       2)  SQLPASSWARD="longli"  --- remote server SQL user password
#
# deploy steps:
#      1、cap deploy:setup
#      2、cap deploy:check
#      3、cap deploy:migrations
#      4、cap deploy:redis:start (start redis and resque)
#
#      cap deploy:restart      --- restart app, redis, resque
#      cap deploy:user:restart --- restart app, resque
#      cap deploy:redis:start  --- start redis
#      cap deploy:resque:start --- start resque

