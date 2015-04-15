require 'spec_helper'

describe Asgit::Services do

  before :all do
    class Foo; end
  end

  before :each do
    if described_class.instance_variable_defined?(:@_registered)
      described_class.send(:remove_instance_variable, :@_registered)
    end
  end

  after :all do
    Asgit::Services.register( Asgit::Services::GitHub, :github )
    Asgit::Services.register( Asgit::Services::Bitbucket, :bitbucket )
  end

  describe "::registered" do
    it "returns a Hash" do
      expect( described_class.registered ).to be_a Hash
    end
  end

  describe "::register" do
    it "adds a service to the registered" do
      expect{ described_class.register(Foo,:foo) }.to change{ Asgit::Services.registered.keys.count }.by(1)
    end

    it "adds service with provided key" do
      described_class.register(Foo,:foo)
      expect( described_class.registered[:foo] ).to eq Foo
    end
  end

  describe "#fetch" do
    it "returns a Service if that service is registered" do
      described_class.register( Foo, :github )
      expect( described_class.fetch(:github) ).to eq Foo
    end

    it "raises UndefinedService if service is not defined" do
      expect{
        described_class.fetch(:foo)
      }.to raise_error Asgit::Services::UndefinedService
    end

    it "finds services if string given" do
      described_class.register( Foo, :github )
      expect( described_class.fetch('github') ).to eq Foo
    end
  end
end


describe Asgit::Services::Service do

  describe "#initialize" do
    it "sets given details to #details" do
      details_double = instance_double("Asgit::Project::Details")
      expect( described_class.new(details_double).details ).to eq details_double
    end
  end

end