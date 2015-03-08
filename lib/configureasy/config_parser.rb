require 'yaml'

# Load and parse content of config (YAML).
# Raise exception if config file not found
#
#    parser = Configureasy::ConfigParser.new('./config/config.yml')
#    # => <# Configureasy::ConfigParser ... >
#    parser.parse
#    # => {:hash => :content}
#
# Set environment to load specific part of config
#
#    parser = Configureasy::ConfigParser.new('./config/environments.yml', 'development')
#    # => <# Configureasy::ConfigParser ... >
#    parser.parse
#    # => {:development => :content}
class Configureasy::ConfigParser
  # Get config filename
  attr_reader :filename
  # Get environment to load data
  attr_reader :environment

  # Initialize ConfigParser instance.
  # Params:
  #  [+filename+]:: name of config file.
  #  [+environment+]:: load specific environment config (*optional*).
  #
  # <b>If config file not found raise an exeception.</b>
  #
  # Returns instance of [Configureasy::ConfigParser]
  def initialize(filename, environment = nil)
    raise "Config #{filename} not found" unless File.exist? filename
    @filename = filename
    @environment = environment || current_environment
  end

  # Returns config content
  def parse
    content = YAML.load_file(filename)
    content.has_key?(self.environment) ? content[self.environment] : content
  rescue
    raise "Invalid config content for #{filename}"
  end

  # Returns config content as [Configureasy::Config]
  def as_config
    Configureasy::Config.new self.parse
  end

  private

  # Gets the current environment.
  # Returns current environment as string. If environment is not set returns 'development'
  def current_environment
    ENV['RUBY_ENV'] || ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
  end

end
