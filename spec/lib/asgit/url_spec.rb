require 'spec_helper'

describe Asgit::Url do

  let(:service) { Asgit::Services.fetch(:github).new.dup }
  let(:details) do
    instance_double( "Asgit::Project::Details",
      organization: 'stevenosloan',
      project: 'asgit',
      default_branch: 'master'
    )
  end

  let(:subject) { described_class.new( details, service ) }

  describe "#initialize" do
    it "sets the details & service attributes" do
      expect( subject.details ).to eq details
      expect( subject.service ).to eq service
    end
  end

  describe "#project" do
    it "returns expected url" do
      expect( subject.project ).to eq 'https://github.com/stevenosloan/asgit'
    end
    it "raises MissingUrlStructure if service doesn't implement #base_structure" do
      allow( service ).to receive(:respond_to?).with(:base_structure).and_return(false)

      expect{
        subject.project
      }.to raise_error Asgit::Services::Service::MissingUrlStructure
    end
  end

  describe "#commit" do
    it "returns url of commit" do
      expect( subject.commit 'commit_sha' ).to eq 'https://github.com/stevenosloan/asgit/commit/commit_sha'
    end
    it "raises MissingUrlStructure if service doesn't implement #commit_uri" do
      allow( service ).to receive(:respond_to?).with(:commit_uri).and_return(false)

      expect{
        subject.commit 'commit_sha'
      }.to raise_error Asgit::Services::Service::MissingUrlStructure
    end
  end

  describe "#branch" do
    it "returns url of the branch" do
      expect( subject.branch 'branch_name' ).to eq 'https://github.com/stevenosloan/asgit/tree/branch_name'
    end
    it "raises MissingUrlStructure if service doesn't implement #branch_uri" do
      allow( service ).to receive(:respond_to?).with(:branch_uri).and_return(false)

      expect{
        subject.branch 'branch_name'
      }.to raise_error Asgit::Services::Service::MissingUrlStructure
    end
  end

  describe '#file' do
    it "returns url for the file" do
      expect( subject.file 'lib/asgit.rb' ).to eq 'https://github.com/stevenosloan/asgit/blob/master/lib/asgit.rb'
    end
    it "adjusts for paths with leading slash" do
      expect( subject.file '/lib/asgit.rb' ).to eq 'https://github.com/stevenosloan/asgit/blob/master/lib/asgit.rb'
    end
    it "returns url for the file on a specific branch" do
      expect( subject.file 'lib/asgit.rb', branch: 'branch_name' ).to eq 'https://github.com/stevenosloan/asgit/blob/branch_name/lib/asgit.rb'
    end
    it "returns url for the file with a line number" do
      expect( subject.file 'lib/asgit.rb', line: '15' ).to eq 'https://github.com/stevenosloan/asgit/blob/master/lib/asgit.rb#L15'
    end
    it "returns url for the file with a range of line numbers" do
      expect( subject.file 'lib/asgit.rb', line: (15..18) ).to eq 'https://github.com/stevenosloan/asgit/blob/master/lib/asgit.rb#L15-L18'
    end
    it "raises MissingUrlStructure if service doesn't implement #file_uri" do
      allow( service ).to receive(:respond_to?).with(:file_uri).and_return(false)

      expect{
        subject.file 'lib/asgit.rb'
      }.to raise_error Asgit::Services::Service::MissingUrlStructure
    end
  end

  describe "#file_at_commit" do
    it "returns url for file at commit_sha" do
      expect( subject.file_at_commit 'lib/asgit.rb', 'commit_sha' ).to eq 'https://github.com/stevenosloan/asgit/blob/commit_sha/lib/asgit.rb'
    end
    it "returns url for file at commit_sha with line numbers" do
      expect( subject.file_at_commit 'lib/asgit.rb', 'commit_sha', line: '15' ).to eq 'https://github.com/stevenosloan/asgit/blob/commit_sha/lib/asgit.rb#L15'
    end
    it "returns url for file at commit_sha with range of line numbers" do
      expect( subject.file_at_commit 'lib/asgit.rb', 'commit_sha', line: (15..18) ).to eq 'https://github.com/stevenosloan/asgit/blob/commit_sha/lib/asgit.rb#L15-L18'
    end
    it "raises MissingUrlStructure if service doesn't implement #file_at_commit_uri" do
      allow( service ).to receive(:respond_to?).with(:file_at_commit_uri).and_return(false)

      expect{
        subject.file_at_commit 'lib/asgit.rb', 'commit_sha'
      }.to raise_error Asgit::Services::Service::MissingUrlStructure
    end
  end

end