# remove files
run "rm README.rdoc"
run "rm public/index.html"

#run "rm public/images/rails.png"

# install sample database file
run "rm config/database.yml"
file 'config/database.yml.example', File.read("#{File.dirname(rails_template)}/database.yml.example")

# install gems
run "rm Gemfile"
file 'Gemfile', File.read("#{File.dirname(rails_template)}/Gemfile")

# bundle install
run "bundle install"

# generate rspec
generate "rspec:install"

# .gitignore
append_file '.gitignore', <<-CODE
config/database.yml
Thumbs.db
.DS_Store
tmp/*
coverage/*
CODE

# keep tmp and log
run "touch tmp/.gitkeep"
run "touch log/.gitkeep"

# git commit
git :init
git :add => '.'
git :add => 'tmp/.gitkeep -f'
git :add => 'log/.gitkeep -f'
git :commit => "-a -m 'initial commit'"

