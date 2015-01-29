require 'yaml'

module Configureasy::Configurable
  # Setting config file name
  #
  # Example
  #   config_name :foo
  #   => APP_ROOT/config/foo.yml
  #
  #   config_name :bar
  #   => APP_ROOT/config/bar.yml
  #
  def config_name(filename = nil)
    @config_name = filename if filename
    @config_name || self.name.downcase
  end

  # Load the config yaml and return Configureasy::Config instance
  def config
    @config ||= load_configs
  end

  # Looks for config file an return true if file exists
  def have_config?
    File.exist? config_filename
  end

  # Reload configs
  def reset_config!
    @config = nil
    config
  end

  private

  def load_configs
    configs_hash = parse_configs
    raise Configureasy::ConfigInvalid, "invalid config file '#{config_filename}'", caller unless configs_hash.is_a? Hash

    Configureasy::Config.new configs_hash[_current_env] || configs_hash
  end

  def parse_configs
    raise Configureasy::ConfigNotFound, "file not found '#{config_filename}'", caller unless have_config?
    YAML.load_file config_filename
  end

  def _current_env
    ENV['RAILS_ENV'] || ENV['RUBY_ENV'] || ENV['RACK_ENV'] || 'development'
  end

  def config_filename
    File.expand_path "./config/#{config_name}.yml"
  end
end
