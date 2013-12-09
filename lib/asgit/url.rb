module Asgit
  class Url

    attr_reader :details, :service

    def initialize details, service
      @details = details
      @service = service
    end

    def project
      service_must_implement :base_structure

      service.base_structure % {
        base_url: service.base_url,
        organization: details.organization,
        project: details.project
      }
    end

    def commit sha
      service_must_implement :commit_uri

      File.join( project, service.commit_uri % { commit: sha } )
    end

    def branch name
      service_must_implement :branch_uri

      File.join( project, service.branch_uri % { branch: name } )
    end

    def file file_path, options={}
      service_must_implement :file_uri

      file_path = file_path.gsub( /^\//, '' )
      branch    = options.fetch(:branch) { details.default_branch }
      line      = options.has_key?(:line) ? format_lines(options[:line]) : ''

      File.join( project, service.file_uri % { file_path: file_path, branch: branch, line: line } )
    end

    def file_at_commit file_path, commit=commit, options={}
      service_must_implement :file_at_commit_uri

      file_path = file_path.gsub( /^\//, '' )
      line      = options.has_key?(:line) ? format_lines(options[:line]) : ''

      File.join( project, service.file_at_commit_uri % { file_path: file_path, commit: commit, line: line } )
    end

    private

      def service_must_implement method
        unless service.respond_to? method
          raise Services::Service::MissingUrlStructure, "service missing url structure for #{method}"
        end
      end

      def format_lines input
        if input.respond_to?(:begin) && input.respond_to?(:end)
          return "#L#{input.begin}-L#{input.end}"
        else
          return "#L#{input}"
        end
      end

  end
end