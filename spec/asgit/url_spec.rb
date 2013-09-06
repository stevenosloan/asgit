require 'spec_helper'

describe Asgit::Url do

  before :all do
    Asgit.configure do |c|
      c.organization = "wu"
      c.project      = "tang"
      c.service      = :github
    end
  end

  after :all do
    Asgit::Services.send(:remove_instance_variable, "@_github")
  end

  describe "::commit" do
    it "returns the correct url for the provided commit" do
      expect( Asgit::Url.commit "woot" ).to eq "https://github.com/wu/tang/commit/woot"
    end
  end

  describe "::branch" do
    it "returns the correct url for the provided branch" do
      expect( Asgit::Url.branch "woot" ).to eq "https://github.com/wu/tang/tree/woot"
    end
  end

end