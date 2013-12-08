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

  describe "::project" do
    it "returns correct url for the project" do
      expect( Asgit::Url.project ).to eq "https://github.com/wu/tang"
    end
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

  describe "::file" do
    it "returns the correct url for a file" do
      expect( Asgit::Url.file "lib/tang.rb" ).to eq "https://github.com/wu/tang/blob/master/lib/tang.rb"
    end

    it "adjust for fives given with a leading slash" do
      expect( Asgit::Url.file "/lib/tang.rb" ).to eq "https://github.com/wu/tang/blob/master/lib/tang.rb"
    end

    it "returns the correct url for a file with a passed branch" do
      expect( Asgit::Url.file "/lib/tang.rb", branch: 'dev' ).to eq "https://github.com/wu/tang/blob/dev/lib/tang.rb"
    end

    it "returns the correct url for a file with a line number" do
      expect( Asgit::Url.file "/lib/tang.rb", branch: 'dev', line: "15" ).to eq "https://github.com/wu/tang/blob/dev/lib/tang.rb#L15"
    end

    it "returns the correct url for a file with a range of line numbers" do
      expect( Asgit::Url.file "/lib/tang.rb", branch: 'dev', line: (15..18) ).to eq "https://github.com/wu/tang/blob/dev/lib/tang.rb#L15-L18"
    end
  end

  describe "::file_at_commit" do
    it "returns url at commit sha" do
      expect( Asgit::Url.file_at_commit "lib/tang.rb", "commit_sha" ).to eq "https://github.com/wu/tang/blob/commit_sha/lib/tang.rb"
    end
  end

end