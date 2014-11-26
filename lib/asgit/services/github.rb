module Asgit
  module Services
    class GitHub < Service

      register_as :github

      def base_url
        "https://github.com"
      end

      def base_structure
        "%{base_url}/%{organization}/%{project}"
      end

      def commit_uri
        "commit/%{commit}"
      end

      def branch_uri
        "tree/%{branch}"
      end

      def file_uri
        "blob/%{branch}/%{file_path}%{line}"
      end

      def file_at_commit_uri
        "blob/%{commit}/%{file_path}%{line}"
      end

      def compare_uri
        "compare/%{ref_a}...%{ref_b}"
      end

    end
  end
end