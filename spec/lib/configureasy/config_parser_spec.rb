require 'spec_helper'

describe Configureasy::ConfigParser do
  describe '.new' do
    before(:each) do
      allow(File).to receive(:exist?) { true }
      allow(ENV).to receive(:[]) { nil }
    end

    it "check if filename exists" do
      expect(File).to receive(:exist?).with('missing_config.yml') { false }
      expect { described_class.new('missing_config.yml') }.to raise_error "Config missing_config.yml not found"
      expect(File).to receive(:exist?).with('missing_config.yml') { true }
      expect(described_class.new 'missing_config.yml').to be_instance_of described_class
    end

    it "set environment to load data" do
      allow(File).to receive(:exist?) { true }
      expect(described_class.new('config.yml', 'stage').environment).to eq 'stage'
    end

    it "get RUBY_ENV" do
      allow(ENV).to receive(:[]).with('RUBY_ENV') { 'ruby_env' }
      expect(described_class.new('config.yml').environment).to eq 'ruby_env'
    end

    it "get RAILS_ENV" do
      allow(ENV).to receive(:[]).with('RAILS_ENV') { 'rails_env' }
      expect(described_class.new('config.yml').environment).to eq 'rails_env'
    end

    it "get RACK_ENV" do
      allow(ENV).to receive(:[]).with('RACK_ENV') { 'rack_env' }
      expect(described_class.new('config.yml').environment).to eq 'rack_env'
    end
  end

  describe '#parse' do
    it "return content of yml" do
      allow(File).to receive(:exist?) { true }
      allow(YAML).to receive(:load_file) { {'yaml' => 'content'} }
      expect(described_class.new('config.yml').parse).to eq({'yaml' => 'content'})
    end
    it 'return config for environment' do
      allow(File).to receive(:exist?) { true }
      allow(YAML).to receive(:load_file) { {'development' => 'wrong', 'test' => 'wrong', 'stage' => 'correct'} }
      allow(ENV).to receive(:[]).with('RUBY_ENV') { 'stage' }
      expect(described_class.new('config.yml').parse).to eq('correct')
    end
  end

  describe '#as_config' do
    it 'return config as Configureasy::Config' do
      allow(File).to receive(:exist?) { true }
      allow(YAML).to receive(:load_file) { {'yaml' => 'content'} }
      expect(described_class.new('config.yml').as_config).to be_instance_of Configureasy::Config
    end
  end

end