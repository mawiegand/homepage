# config valid only for current version of Capistrano
lock '3.11.0'

set :application, 'homepage'
set :repo_url, 'https://github.com/mawiegand/homepage.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/mwiegand/rails/homepage'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'public/.htaccess'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc "Restart service"
  task :restart do
    on roles(:all) do
      execute :supervisorctl, 'restart homepage'
    end
  end
end

namespace :print do
  desc "Print environment variables"
  task :environment do
    on roles(:all) do
      execute :printenv
    end
  end
end

after 'deploy', 'deploy:restart'
