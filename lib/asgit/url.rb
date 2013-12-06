module Asgit
  module Url

    class << self

      def project
        Asgit.config.service.base_structure % {
          base_url: Asgit.config.service.base_url,
          organization: Asgit.config.organization,
          project: Asgit.config.project
        }
      end

      def commit sha
        File.join( project, Asgit.config.service.commit_uri % { commit: sha } )
      end

      def branch name
        File.join( project, Asgit.config.service.branch_uri % { branch: name } )
      end

      def file file_path, options={}
        file_path = file_path.gsub( /^\//, '' )
        branch    = options.fetch(:branch) { Asgit.config.default_branch }
        line      = options.has_key?(:line) ? format_lines(options[:line]) : ''

        File.join( project, Asgit.config.service.file_uri % { file_path: file_path, branch: branch, line: line } )
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
end