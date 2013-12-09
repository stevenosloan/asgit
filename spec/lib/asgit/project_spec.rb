require 'spec_helper'

describe Asgit::Project do

  describe "#initialize" do
    it "sets detail's attributes" do
      details_double = instance_double( "Asgit::Project::Details" )
      allow( Asgit::Project::Details ).to receive(:new).and_return(details_double)

      expect( details_double ).to receive(:service=)
      expect( details_double ).to receive(:organization=)
      expect( details_double ).to receive(:project=)
      expect( details_double ).to receive(:default_branch=)

      described_class.new( service: :github,
                           organization: 'stevenosloan',
                           project: 'asgit',
                           default_branch: 'master' )
    end

    it "raises an ArgumentError if an out-of-scope arg is passed" do
      expect{
        described_class.new( foo: 'bar' )
      }.to raise_error ArgumentError, 'unknown keyword: foo'
    end
  end

  describe "#details" do
  end

end