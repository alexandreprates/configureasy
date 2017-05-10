require 'yaml'

# Allows loading of different configuration files.
#
#    class Dumb
#      include Configureasy
#
#      # create class method _config_ with content of config/config.yml
#      load_config :config
#
#      # create class method _secrets_ with content for config/session_secrets.yml
#      load_config :session_secrets, as: :secrets
#
#      # create class method _aws_keys_ with content for './aws/keys.yml'
#      load_config :keys, as: :aws_keys, path: './aws'
#    end
module Configureasy::Configurable
  @@configurables = {}

  # dinamically create method for access config data.
  # Params:
  #  [+file_basename+]:: config file name (by default in *config* directory)
  #  [+as+]:: generated method name (by default same as file_basename)
  #  [+path+]:: config path (by default './config')
  def load_config(file_basename, options = {})
    name = options[:as] || file_basename
    path = options[:path] || './config'
    filename = File.join path, "#{file_basename}.yml"
    _configurable_init(name, filename)
  end

  # @deprecated Please use {#load_config} instead.
  # Setting config source filename.
  # Params:
  #  [+name+]:: the name of config file
  #
  #    # load contents for ./config/foo.yml
  #    config_name :foo
  #
  #    # load contents for ./config/bar.yml
  #    config_name :bar
  def config_name(name = nil)
    warn "[DEPRECATION] `config_name` is deprecated.  Please use `load_config` instead."
    load_config name, as: 'config'
  end

  # @deprecated Please use {#load_config} instead.
  # Load config in specific location.
  # Params
  #  [+filename+]:: config filename
  #
  #    # load contents for /etc/my_configs.yml
  #    config_filename '/etc/my_configs.yml'
  def config_filename(filename = nil)
    warn "[DEPRECATION] `config_filename` is deprecated.  Please use `load_config` instead."
    basename = File.basename(filename, '.yml')
    path = File.dirname(filename)
    load_config basename, as: 'config', path: path
  end

  private

  def _configurable_init(method_name, filename)
    @@configurables[_configurable_key(method_name)] = { filename: filename, payload: nil }
    unless self.class.respond_to? method_name
      self.class.send(:define_method, method_name) { _configurable_for(method_name) }
      self.class.send(:define_method, "#{method_name}_reload!") { _configurable_reload(method_name) }
    end
  end

  def _configurable_key(method_name)
    "#{self}.#{method_name}"
  end

  def _configurable_hash(method_name)
    @@configurables[_configurable_key(method_name)]
  end

  def _configurable_for(method_name) # :nodoc:
    _configurable_hash(method_name)[:payload] || _configurable_reload(method_name)
  end

  def _configurable_reload(method_name) # :nodoc:
    _configurable_hash(method_name)[:payload] = Configureasy::ConfigParser.new(_configurable_hash(method_name)[:filename]).as_config
  end

end
