require 'spec_helper'

describe Asgit do

  describe "::working_tree_clean?" do
    it "is true when nothing to commit" do
      stub_shell 'git status --porcelain'
      expect( Asgit.working_tree_clean? ).to be_truthy
    end
    it "is false when tree isn't clean" do
      stub_shell 'git status --porcelain', stdout: "M changelog.md\n"
      expect( Asgit.working_tree_clean? ).to be_falsy
    end
  end

  describe "::current_branch" do
    it "returns master when on master" do
      stub_shell 'git symbolic-ref HEAD --short', stdout: "master\n"
      expect( Asgit.current_branch ).to eq "master"
    end

    it "raises exception on error response" do
      stub_shell 'git symbolic-ref HEAD --short', stderr: "so much fails\n", stdout: '', status: false

      expect{
        Asgit.current_branch
      }.to raise_error Asgit::Shell::ResponseError
    end
  end

  describe "::current_commit" do
    it "returns current commit" do
      stub_shell 'git rev-parse HEAD', stdout: 'commit_sha'
      expect( Asgit.current_commit ).to eq 'commit_sha'
    end
  end

  describe "::remote_up_to_date?" do
    it "returns true if remote is current" do
      stub_shell 'git push --dry-run --porcelain',
                  stdout: "To git@github.com:stevenosloan/asgit.git\n" +
                          "=\tHEAD:refs/heads/master\t[up to date]\n" +
                          "Done\n"
      allow( Asgit ).to receive(:current_branch).and_return("master")
      expect( Asgit.remote_up_to_date? ).to be_truthy
    end
    it "returns false if remote is out of sync" do
      stub_shell 'git push --dry-run --porcelain',
                 stdout: "To git@github.com:stevenosloan/asgit.git\n" +
                         "\tHEAD:refs/heads/master\t5871eb5..0ce6c7f\n" +
                         "Done\n"
      allow( Asgit ).to receive(:current_branch).and_return("master")
      expect( Asgit.remote_up_to_date? ).to be_falsy
    end
  end

end