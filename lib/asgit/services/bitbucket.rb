module Asgit
  module Services
    class Bitbucket < Service

      register_as :bitbucket

      def base_url
        "https://bitbucket.org"
      end

      def base_structure
        "%{base_url}/%{organization}/%{project}"
      end

      def commit_uri
        "commits/%{commit}"
      end

      def branch_uri
        "branch/%{branch}"
      end

      def file_at_commit_uri
        "src/%{commit}/%{file_path}?at=%{branch}"
      end

    end
  end
end