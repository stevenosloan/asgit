require 'rspec'
require 'pry-debugger'

require 'asgit'

require 'support/fake_stdout'
require 'support/eat_stdout'

describe "spec_helper" do
  describe "Asgit::Shell.fake_stdout" do
    it "overrides the actual stdout for Asgit::Shell" do
      Asgit::Shell.fake_stdout "woo" do
        expect( Asgit::Shell.run("foo")[1] ).to eq "woo"
      end
    end
  end
  describe "Asgit::Shell.fake_stderr" do
    it "overrides the actual stderr for Asgit::Shell" do
      Asgit::Shell.fake_stderr "woo" do
        expect( Asgit::Shell.run("foo")[2] ).to eq "woo"
      end
    end
  end
end