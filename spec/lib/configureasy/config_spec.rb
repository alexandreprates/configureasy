require 'spec_helper'

describe Configureasy::Config do
  describe ".new" do
    it "should store key/value as methods" do
      expect(Configureasy::Config.new(foo: 'bar').foo).to eq('bar')
    end
  end

  describe "#as_hash" do

  end
end