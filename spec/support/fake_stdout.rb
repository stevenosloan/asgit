module Asgit
  module Shell
    class << self

      def fake_stdout out
        set_stdout out
        yield
      ensure
        unset_stdout
      end

      def fake_stderr err
        set_stderr err
        yield
      ensure
        unset_stderr
      end

      def patched_run command, &block
        if @shell_out || @shell_err
          yield @shell_out if block_given?
          [ true, @shell_out, @shell_err ]
        else
          system_run command, &block
        end
      end

      def set_stdout out
        @shell_out = out
      end

      def unset_stdout
        @shell_out = nil
      end

      def set_stderr err
        @shell_err = err
      end

      def unset_stderr
        @shell_err = nil
      end

      alias_method :system_run, :run
      alias_method :run, :patched_run
    end
  end
end