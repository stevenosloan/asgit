require 'spec_helper'

describe Asgit::Shell do
  describe "::run" do
    it "calls HereOrThere::Local#run with the provided command" do
      expect_any_instance_of(HereOrThere::Local).to receive(:run)
                                                .with('ls')

      Asgit::Shell.run 'ls'
    end
  end
end