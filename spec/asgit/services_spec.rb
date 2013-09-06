require 'spec_helper'

describe Asgit::Services do

  it "returns a Service for services that exist" do
    expect( Asgit::Services.github.class ).to eq Asgit::Services::Service
  end

  it "doesn't redefine a service if it is set" do
    Asgit::Services.instance_variable_set("@_github", "foo")
    expect( Asgit::Services.github ).to eq "foo"

    # teardown, just to keep from poluting the rest of the tests
    Asgit::Services.send(:remove_instance_variable, "@_github")
  end

  describe Asgit::Services::Service do

    let(:github) { Asgit::Services.github }

    it "returns data for each key" do
      expect( github.base_url ).to eq "https://github.com"
    end

  end

end