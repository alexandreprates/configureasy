require 'ostruct'

##
# Class for store and retrive config values
#
# Example
#   >> Confugureasy::Config.new(foo: 'foo').foo
#   => 'foo'
#
#  >> Configureasy::Config.new(:foo => {:bar => :value}).foo.bar
#  => :value
#
# You can access values using [] too
#
# Example
#    >> Configureasy::Config.new(foo: 'bar')[:foo]
#    => 'bar'
#
# Beside you retrive data as hash
#
# Example
#    >> Configureasy::Config(foo: 'bar').as_hash
#    => {:foo => 'bar'}
class Configureasy::Config < OpenStruct

  # Convert a hash data into methods recursively
  def initialize(params = {})
    @hash = params
    params = params.inject({}) do |hash, data|
      key, value = data
      value = self.class.new(value) if value.is_a? Hash
      hash.merge key.to_sym => value
    end
    super params
  end

  # return config as hash
  def as_hash
    @hash
  end
end
