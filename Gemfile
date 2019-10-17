source 'https://rubygems.org'

# Specify your gem's dependencies in configureasy.gemspec
gemspec

group :development do
  gem 'terminal-notifier', '1.6.2'
  gem 'terminal-notifier-guard', '1.6.4'
  gem 'pry', '0.10.1'
  gem 'pry-nav', '0.2.4'
end

group :test do
  gem 'rake', '10.4.2'
  gem 'rspec', '3.2.0'

  gem 'tins', '1.21.1' # coveralls dependency
  gem 'term-ansicolor', '1.3.0' # coveralls dependency
  gem 'rb-fsevent', '0.9.4' # guard-rspec dependency
  gem 'rb-inotify', '0.9.5' # guard-rspec dependency

  gem 'guard-rspec', '4.5.0'
  gem 'coveralls', '0.7.11', require: false
end
