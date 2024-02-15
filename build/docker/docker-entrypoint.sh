# bin/bash

#!/bin/bas
set -e
	
# Remove a potentially pre-existing server.pid for Rails.
rm -f /docker-rails-boilerplate/tmp/pids/server.pid
	
bundle exec puma -C config/puma.rb