require 'spec_helper'

describe Asgit::Project do

  let(:default_details) do
    {
      service: :github,
      organization: 'stevenosloan',
      project: 'asgit',
      default_branch: 'master'
    }
  end

  let(:default_project) { described_class.new( default_details ) }

  describe "#initialize" do
    it "sets detail's attributes" do
      details_double = instance_double( "Asgit::Project::Details" )
      allow( Asgit::Project::Details ).to receive(:new).and_return(details_double)

      expect( details_double ).to receive(:service=).with(:github)
      expect( details_double ).to receive(:organization=).with('stevenosloan')
      expect( details_double ).to receive(:project=).with('asgit')
      expect( details_double ).to receive(:default_branch=).with('master')

      described_class.new( default_details )
    end

    it "raises an ArgumentError if an out-of-scope arg is passed" do
      expect{
        described_class.new( foo: 'bar' )
      }.to raise_error ArgumentError, 'unknown keyword: foo'
    end
  end

  describe "#details" do
    it "returns a Details instance" do
      expect( default_project.details.is_a? Asgit::Project::Details ).to be_truthy
    end

    it "returns the same instance on each call" do
      expect( default_project.details ).to eq default_project.details
    end
  end

  describe "#service" do
    before :each do
      double( "Asgit::Service" )
    end
    it "returns a Service instance" do
      expect( default_project.service.is_a? Asgit::Services::Service ).to be_truthy
    end
    it "creates Service instance with defined service" do
      expect( Asgit::Services ).to receive(:github)

      default_project.service
    end
  end

end