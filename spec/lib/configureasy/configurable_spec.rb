require 'spec_helper'

describe Configureasy::Configurable do
  before(:each) do
    allow(File).to receive(:exist?) { true }
    allow(YAML).to receive(:load_file) { {'works' => 'true'} }
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

    it "load config content into config method" do
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

    it "load config with filename into config method" do
      expect(dumb_class).to respond_to :config
      expect(dumb_class.config.works).to eq('true')
    end
  end

end