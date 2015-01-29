require "configureasy/version"

# Configureasy is a easy way to getting configs into you class/model
#
# =Example=
#  class Foo
#    include Configureasy
#    config_name :bar # ROOT_DIR/config/bar.yml
#
#    def make_something
#      config.some_setting # automatically return _some_setting_ value in config
#    end
#
#  end
#
module Configureasy
  # Class to raise error on missing config file _yaml_
  class ConfigNotFound < Exception; end
  # Class to raise error on invalid config file
  class ConfigInvalid < Exception; end


  def self.included(receiver)
    receiver.extend Configurable
  end
end

require 'configureasy/config'
require 'configureasy/configurable'
