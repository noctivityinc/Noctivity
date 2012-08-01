$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.

require "bundler/capistrano"
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.3@noc'        # Or whatever env you want it to run in.


set :application, "Noctivity Website"
set :repository,  "git@github.com:noctivityinc/Noctivity.git"

set :scm, :git
set :branch,          "github/master"
set :migrate_target,  :current
set :ssh_options,     { :forward_agent => true }
set :rails_env,       "production"
set :deploy_to,       "/home/noctivity/current"
set :normalize_asset_timestamps, false

role :web, "noctivity.com"                          # Your HTTP server, Apache/etc
role :app, "noctivity.com"                          # This may be the same as your `Web` server
role :db,  "noctivity.com", :primary => true # This is where Rails migrations will run


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


namespace :rvm do
  task :trust_rvmrc do
    run \"rvm rvmrc trust \#\{release_path\}\"
  end
end

after "deploy", "rvm:trust_rvmrc"
