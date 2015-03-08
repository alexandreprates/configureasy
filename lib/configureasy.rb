require "configureasy/version"

# Configureasy is a easy way to getting configs into you class/model
#
# Example
#
#   class Foo
#     include Configureasy
#   end
#   Foo.config.some_key
#   => 'some value'
#
#  class Bar
#    include Configureasy
#    config_name :barz #looks for APP_DIR/config/barz.yml
#  end
#
#   class FooBar
#     include Configureasy
#     def internal_access
#       value = self.class.some_key
#       ...
#     end
#   end
#
module Configureasy
  # Class to raise error on missing config file _yaml_
  class ConfigNotFound < Exception; end
  # Class to raise error on invalid config file
  class ConfigInvalid < Exception; end

  def self.included(receiver) # :nodoc:
    receiver.extend Configurable
  end
end

require 'configureasy/config'
require 'configureasy/config_parser'
require 'configureasy/configurable'
