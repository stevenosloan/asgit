require 'spec_helper'

describe Asgit do

  describe "::working_tree_clean?" do
    it "is true when nothing to commit" do
      Asgit::Shell.fake_stdout "" do
        expect( Asgit.working_tree_clean? ).to be_truthy
      end
    end
    it "is false when tree isn't clean" do
      Asgit::Shell.fake_stdout "M changelog.md\n" do
        expect( Asgit.working_tree_clean? ).to be_falsy
      end
    end
  end

  describe "::current_branch" do
    it "returns master when on master" do
      Asgit::Shell.fake_stdout "master" do
        expect( Asgit.current_branch ).to eq "master"
      end
    end
  end

  describe "::current_commit" do
    it "returns current commit" do
      Asgit::Shell.fake_stdout "12345" do
        expect( Asgit.current_commit ).to eq "12345"
      end
    end
  end

  describe "::remote_up_to_date?" do
    it "returns true if remote is current" do
      Asgit::Shell.fake_stdout "To git@github.com:stevenosloan/asgit.git\n" +
                               "=\tHEAD:refs/heads/master\t[up to date]\n" +
                               "Done\n" do
        allow( Asgit ).to receive(:current_branch).and_return("master")
        expect( Asgit.remote_up_to_date? ).to be_truthy
      end
    end
    it "returns false if remote is out of sync" do
      Asgit::Shell.fake_stdout "To git@github.com:stevenosloan/asgit.git\n" +
                               "\tHEAD:refs/heads/master\t5871eb5..0ce6c7f\n" +
                               "Done\n" do
        allow( Asgit ).to receive(:current_branch).and_return("master")
        expect( Asgit.remote_up_to_date? ).to be_falsy
      end
    end
  end

end