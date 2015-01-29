require 'ostruct'

##
# Class for store and retrive config values
#
# Example
#   >> Confugureasy::Config.new(foo: 'foo').foo
#   => 'foo'
#
class Configureasy::Config < OpenStruct
  # return config as hash
  def raw_content
    @table
  end
end
