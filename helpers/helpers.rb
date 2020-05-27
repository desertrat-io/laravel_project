module LaravelProject
  module Helpers
    class ComposerHelper
      attr_reader :composer_path, :composer_scripts

      @composer_scripts = []

      def composer_require(package_name, is_dev)
        @package_def = {
            name: package_name,
            dev: is_dev
        }

      end
      def composer_add_script(script_command)
        Array.push(@composer_scripts, script_command)
      end

      def composer_path=(path)
        @composer_path = path
      end

      def is_composer_installed?
        # test the usual suspects, then the user provided path
        raise RuntimeError 'windows detection not supported!' if Chef::Platform::windows?

        ::File.exists?('/usr/local/bin/composer') || ::File.exists?('/usr/bin/composer') || ::File.exists?(@composer_path)
      end

      def install_composer_phar

      end
    end
  end
end