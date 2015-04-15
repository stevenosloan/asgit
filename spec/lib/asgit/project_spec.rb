require 'spec_helper'

describe Asgit::Project do

  let(:default_details) do
    {
      service: :github,
      organization: 'stevenosloan',
      project: 'asgit',
      default_branch: 'master',
      base_url: "https://my.repo.url"
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
      expect( details_double ).to receive(:base_url=).with('https://my.repo.url')

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
    it "returns a Service instance with defined service" do
      expect( default_project.service.is_a? Asgit::Services::GitHub ).to be_truthy
    end
  end

  describe "#urls" do
    it "returns a Url instance" do
      expect( default_project.urls.is_a? Asgit::Url ).to be_truthy
    end

    it "creates Url instance with #details and #service" do
      expect( Asgit::Url ).to receive(:new).with( default_project.details, default_project.service )

      default_project.urls
    end
  end

end