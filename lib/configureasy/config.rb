require 'ostruct'

##
# Class for access the config settings
class Configureasy::Config < OpenStruct
  # return config as hash
  def as_hash
    @table
  end
end
