require 'spec_helper'

describe Asgit::Config do

  describe "#default_branch" do
    context "when no branch is set" do
      it "returns 'master'" do
       expect( Asgit::Config.new.default_branch ).to eq 'master'
      end
    end
    context "when a branch is set" do
      it "returns the set branch" do
        config = Asgit::Config.new
        config.default_branch = 'foo'
        expect( config.default_branch ).to eq 'foo'
      end
    end
  end

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

  describe "::configured?" do
    it "returns false if configuration hasn't been set" do
      expect( Asgit.configured? ).to be_falsy
    end

    it "returns false if config is partially set" do
      Asgit.configure do |c|
        c.project = 'foo'
      end

      expect( Asgit.configured? ).to be_falsy
    end

    it "returns true if configuration has been set" do
      Asgit.configure do |c|
        c.project      = 'foo'
        c.organization = 'bar'
        c.service      = :github
      end

      expect( Asgit.configured? ).to be_truthy
    end
  end

end