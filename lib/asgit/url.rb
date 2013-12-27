module Asgit
  class Url

    attr_reader :details, :service

    def initialize details, service
      @details = details
      @service = service
    end

    def project
      service.base_structure % {
        base_url: service.base_url,
        organization: details.organization,
        project: details.project
      }
    end

    def commit sha
      File.join( project, service.commit_uri % { commit: sha } )
    end

    def branch name
      File.join( project, service.branch_uri % { branch: name } )
    end

    def file file_path, options={}
      file_path = file_path.gsub( /^\//, '' )
      branch    = options.fetch(:branch) { details.default_branch }
      line      = options.has_key?(:line) ? format_lines(options[:line]) : ''

      File.join( project, service.file_uri % { file_path: file_path, branch: branch, line: line } )
    end

    def file_at_commit file_path, commit=commit, options={}
      file_path = file_path.gsub( /^\//, '' )
      line      = options.has_key?(:line) ? format_lines(options[:line]) : ''

      File.join( project, service.file_at_commit_uri % { file_path: file_path, commit: commit, line: line } )
    end

    private

      def format_lines input
        if input.respond_to?(:begin) && input.respond_to?(:end)
          return "#L#{input.begin}-L#{input.end}"
        else
          return "#L#{input}"
        end
      end

  end
end