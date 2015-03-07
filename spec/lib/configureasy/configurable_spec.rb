require 'spec_helper'

class Foo
  extend Configureasy::Configurable
end

describe Configureasy::Configurable do
  describe ".config_name" do
    it "by default config name is class name" do
      expect(Foo.config_name).to eq('foo')
    end

    it "changes config name" do
      expect(Foo.config_name).to eq('foo')
      Foo.config_name "bar"
      expect(Foo.config_name).to eq('bar')
    end

    it "config name reflects on config_filename" do
      Foo.config_name "other_conf"
      expect(Foo.send :config_filename).to match(/other_conf\.yml$/)
    end
  end

  describe '.config_filename' do
    it "set config filename" do
      Foo.config_filename '.hidedir/secret_config.yml'
      expect(Foo.config_filename).to end_with('.hidedir/secret_config.yml')
    end
  end

  describe '#config' do
    let(:yaml_content) { {'development' => {'foo' => 'development'}, 'production' => {'foo' => 'production'} } }

    it "raise excepion when file missing" do
      expect { Foo.config }.to raise_exception Configureasy::ConfigNotFound
    end

    it "raise exception when file content is not valid yaml" do
      allow(YAML).to receive(:load_file).and_return("wrong yaml content")
      allow(File).to receive(:exist?).and_return(true)

      expect { Foo.config }.to raise_exception Configureasy::ConfigInvalid
    end

    it "access values on config file" do
      allow(YAML).to receive(:load_file).and_return(yaml_content)
      allow(File).to receive(:exist?).and_return(true)
      allow(ENV).to receive(:[]).and_return(nil)

      expect(Foo.config).to respond_to(:foo)
      expect(Foo.config.foo).to eq('development')
    end

    it "load contend for current environment" do
      allow(ENV).to receive(:[]).and_return(nil)
      allow(YAML).to receive(:load_file).and_return(yaml_content)
      allow(File).to receive(:exist?).and_return(true)

      allow(ENV).to receive(:[]).with('RUBY_ENV').and_return('development')
      expect(Foo.reset_config!.foo).to eq('development')

      allow(ENV).to receive(:[]).with('RUBY_ENV').and_return('production')
      expect(Foo.reset_config!.foo).to eq('production')

      allow(ENV).to receive(:[]).with('RUBY_ENV').and_return(nil)

      allow(ENV).to receive(:[]).with('RACK_ENV').and_return('development')
      expect(Foo.reset_config!.foo).to eq('development')

      allow(ENV).to receive(:[]).with('RAILS_ENV').and_return('production')
       expect(Foo.reset_config!.foo).to eq('production')
    end

    it "config is kind of Configs class" do
      allow(YAML).to receive(:load_file).and_return(yaml_content)
      allow(File).to receive(:exist?).and_return(true)

      expect(Foo.config).to be_kind_of(Configureasy::Config)
    end
  end
end