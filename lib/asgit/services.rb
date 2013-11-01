module Asgit
  module Services

    DATA = {
      github: {
        base_url: 'https://github.com',
        base_structure: "%{base_url}/%{organization}/%{project}",
        commit_uri: "commit/%{commit}",
        branch_uri: "tree/%{branch}",
        file_uri: "blob/master/%{file_path}"
      }
    }

    DATA.each_key do |service|
      define_singleton_method(service) do
        instance_variable_get("@_#{service}") || instance_variable_set("@_#{service}", Service.new( DATA[service] ))
      end
    end

    class Service

      def initialize data
        data.each do |attr, val|
          self.class.send(:define_method, attr) { val }
        end
        return self.freeze
      end

    end

  end
end