require_relative 'asgit/shell'
require_relative 'asgit/url'
require_relative 'asgit/services'
require_relative 'asgit/project'

module Asgit
  class << self

    # Check if working tree is clean
    # @return [Boolean] true if branch is clean
    def working_tree_clean?
      Shell.run( "git status --porcelain" ).stdout.empty?
    end

    # Get current git branch based on exec directory
    # @return [String] the current checked out branch
    def current_branch
      Shell.run( "git symbolic-ref HEAD --short" ).stdout.strip
    end

    # Get current git commit based on exec directory
    # @return [String] the current commit level
    def current_commit
      Shell.run( "git rev-parse HEAD" ).stdout.strip
    end

    # Check if branch is in sync with remote
    # @return [Boolean]
    def remote_up_to_date?
      resp = Shell.run "git push --dry-run --porcelain"
      return resp.success? && resp.stdout.match(/#{current_branch}\s+?\[up\sto\sdate\]/)
    end

  end
end
