require 'ostruct'

# Store data structure (Hash) and allow access values using method calling
#
#    Confugureasy::Config.new(foo: 'foo').foo
#    # => 'foo'
#
#    Configureasy::Config.new(:foo => {:bar => :value}).foo.bar
#    # => :value
#
# You can access values using [] too
#
#    Configureasy::Config.new(foo: 'bar')[:foo]
#    # => 'bar'
#
# Beside you retrive data as hash
#
#    Configureasy::Config(foo: 'bar').as_hash
#    # => {:foo => 'bar'}
class Configureasy::Config < OpenStruct

  # Convert a hash data into methods recursively.
  # Params:
  #  [+params+]:: Hash with data do convert
  def initialize(params = {})
    @hash = params
    params = params.inject({}) do |hash, data|
      key, value = data
      value = self.class.new(value) if value.is_a? Hash
      hash.merge key.to_sym => value
    end
    super params
  end

  # Return data for config
  # Params:
  #  [+key+]:: name of config
  #
  #    Configureasy::Config.new(foo: 'bar')[:foo]
  #    # => 'bar'
  def [](key)
    self.send key
  end

  # return config as hash
  def as_hash
    @hash
  end
end
