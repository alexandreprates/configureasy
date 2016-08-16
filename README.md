Configureasy
=============

[![Build Status](https://travis-ci.org/alexandreprates/configureasy.svg?branch=master)](https://travis-ci.org/alexandreprates/configureasy) [![Coverage Status](https://coveralls.io/repos/alexandreprates/configureasy/badge.svg)](https://coveralls.io/r/alexandreprates/configureasy) [![Inline docs](http://inch-ci.org/github/alexandreprates/configureasy.svg?branch=master)](http://inch-ci.org/github/alexandreprates/configureasy) [![Code Climate](https://codeclimate.com/github/alexandreprates/configureasy/badges/gpa.svg)](https://codeclimate.com/github/alexandreprates/configureasy)

Configureasy is a library for load configs quickly and easily.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'configureasy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install configureasy

## Usage

Load content of <i>config/database.yml</i>

```ruby
# in ./config/database.yml
# host: localhost
# port: 1234

class DBConfig
  include Configureasy
  load_config :database
end

# You can access config values
DBConfig.database.host # => 'localhost'
DBConfig.database.port # => 1234
```

Setting different method name

```ruby
# in ./config/user_keys.yml
# name: secret_key
# value: secret_key_value

class User
  include Configureasy
  load_config :user_keys, as: :keys
end

User.keys.name # => 'secret_key'
User.keys.value # => 'secret_key_value'
```

Setting different folder

```ruby
class Censor
  include Configureasy
  load_config :forbidden_words, path: './blacklist'
  # load './blacklist/forbidden_words.yml'
end
```

Configureasy detect per environment configs

```ruby
# in ./config/aws.yml
# development:
#   access: development_access
#   secret: development_secret
# production:
#   access: production_access
#   secret: production_secret

class S3Storage
  include Configureasy
  load_config :aws
end

# in development
S3Storage.aws.access # => 'development_access'

# in production
S3Storage.aws.access # => 'production_access'
```

You can access config data as Hash

```ruby
# in ./config/access.yml
# admin_group: 1
# user_group: 2

class User
  require Configureasy
  load_config :access
end

User.access.as_hash
# => {'admin_group' => '1', 'user_group' => '2'}
```

## Contributing

1. Fork it ( https://github.com/alexandreprates/configureasy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request.

