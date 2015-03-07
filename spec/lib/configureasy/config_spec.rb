require 'spec_helper'

describe Configureasy::Config do
  let(:values) { {'first_level' => {'second_level' => 'second_level_value'}, 'single_level' => 'single_level_value'} }
  let(:config) { described_class.new(values) }
  describe '.new' do
    it 'convert multi level hash' do
      expect(config.first_level.second_level).to eq 'second_level_value'
    end
  end

  describe '#[]' do
    it 'return value for a key' do
      expect(config[:single_level]).to eq 'single_level_value'
    end
  end

  describe '#.as_hash' do
    it "return raw content" do
      expect(config.as_hash).to eq values
    end
  end

end