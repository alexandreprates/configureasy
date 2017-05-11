#encoding: utf-8

require 'spec_helper'

describe Configureasy::Configurable do
  before(:each) do
    allow(File).to receive(:exist?) { true }
    allow(YAML).to receive(:load_file) { { 'works' => 'true' } }
  end

  context 'when I have two modules with same config name' do
    before do
      module Foo
        include Configureasy
        load_config :foo, as: :config
      end
      module Bar
        include Configureasy
        load_config :bar, as: :config
      end
      expect(YAML).to receive(:load_file).with('./config/foo.yml') do
        { 'name' => 'andré' }
      end
      expect(YAML).to receive(:load_file).with('./config/bar.yml') do
        { 'name' => 'rodrigo' }
      end
    end

    it 'has different outputs' do
      expect(Foo.config).not_to eq(Bar.config)
    end
  end

  describe '.load_config' do
    let(:dumb_class) do
      Class.new do
        extend Configureasy::Configurable
        load_config :dumb_config
        load_config :another_config
      end
    end

    it 'dynamically generate methods' do
      expect(dumb_class).to respond_to :dumb_config
    end

    it 'support more than one config' do
      expect(dumb_class).to respond_to :another_config
    end

    it 'return ConfigParser content' do
      expect(dumb_class.dumb_config.works).to eq 'true'
    end
  end

  describe '.config_reload!' do
    let(:dumb_class) do
      Class.new do
        extend Configureasy::Configurable
        load_config :config
      end
    end

    it 'reloading config file content' do
      expect(dumb_class.config).not_to be dumb_class.config_reload!
    end
  end

  describe '.config_name' do
    let(:dumb_class) do
      Class.new do
        extend Configureasy::Configurable
        config_name :deprecated
      end
    end

    it 'load config content into config method' do
      expect(dumb_class).to respond_to :config
      expect(dumb_class.config.works).to eq('true')
    end
  end

  describe '.config_filename' do
    let(:dumb_class) do
      Class.new do
        extend Configureasy::Configurable
        config_filename './deprecated/feature.yml'
      end
    end

    it 'load config with filename into config method' do
      expect(dumb_class).to respond_to :config
      expect(dumb_class.config.works).to eq('true')
    end
  end
end
