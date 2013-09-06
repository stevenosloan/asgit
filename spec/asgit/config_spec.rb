require 'spec_helper'

describe Asgit::Config do

  describe "::config" do
    it "returns a config" do
      expect( Asgit.config.class ).to eq Asgit::Config
    end
  end

  describe "::configure" do
    it "yields the config" do
      Asgit.configure do |config|
        expect( config.class ).to eq Asgit::Config
      end
    end

    it "sets attributes on Config" do
      Asgit.configure do |config|
        config.project = "woot"
      end

      expect( Asgit.config.project ).to eq "woot"
    end

    describe "#service" do
      it "sets as an Asgit::Services::Service" do
        Asgit.configure do |c|
          c.service = :github
        end

        expect( Asgit.config.service.class ).to eq Asgit::Services::Service
      end
    end
  end

end