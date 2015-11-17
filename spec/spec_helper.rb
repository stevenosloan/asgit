require 'rspec'
require 'pry-byebug'

require 'asgit'

require 'support/stubbed_shell'
require 'support/eat_stdout'

RSpec.configure do |config|
  config.include StubbedShell
end

describe "spec_helper" do
  describe "stub_shell" do
    it "overrides the actual stdout for Asgit::Shell" do
      stub_shell 'foo', stdout: 'woo'
      expect( Asgit::Shell.run('foo').stdout ).to eq 'woo'
    end
    it "overrides the actual stderr for Asgit::Shell" do
      stub_shell 'foo', stderr: 'woo'
      expect( Asgit::Shell.run('foo').stderr ).to eq 'woo'
    end
    it "overrides the actual status for Asgit::Shell" do
      stub_shell 'foo', status: false
      expect( Asgit::Shell.run('foo').success? ).to be_falsy
    end
  end
end