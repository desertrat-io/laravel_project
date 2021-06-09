module LaravelProject
  module Helpers
    class << self
      def check_for_windows!
        raise RuntimeError 'windows detection not supported!' if Chef::Platform::windows?
      end
    end
  end
  module ComposerHelper
    class << self
      attr_reader :composer_path, :composer_scripts

      @composer_scripts = []
      @composer_packages = []
      @composer_local_path = '/usr/local/bin/composer'
      @composer_system_path = '/usr/bin/composer'
      # sensible default
      @composer_path = @composer_local_path

      def composer_require(package_name, is_dev = false)
        Array.push(@composer_packages, {
            name: package_name,
            dev: is_dev
        })
      end

      def composer_add_script(script_command)
        Array.push(@composer_scripts, script_command)
      end

      def composer_path=(path)
        @composer_path = path
      end

      def is_composer_installed?
        # test the usual suspects, then the user provided path
        LaravelProject::Helpers.check_for_windows!
        detect_current_path
        ChefUtils.file_exist?(@composer_local_path) || ChefUtils.file_exist?(@composer_system_path) || ChefUtils.file_exist?(@composer_path)
      end

      def detect_current_path(prefer_custom = true)
        # this may already exist, or it may have been set already
        unless ChefUtils.file_exist?(@composer_path) and !prefer_custom
          if ChefUtils.file_exist?(@composer_local_path)
            @composer_path = @composer_local_path
          elsif ChefUtils.file_exist?(@composer_system_path)
            @composer_path = @composer_system_path
          end
        end
        @composer_path
      end

      def install_composer_phar(version = 'stable')
        raise RuntimeError if @composer_path == nil or @composer_path == '' or shell_out('php') == nil
        get_installer_result = shell_out 'php -r "copy(\'https://getcomposer.org/installer\', \'composer-setup.php\');"'
        checksum_result = shell_out <<CHECKSUM
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e5325b19b381bfd88ce90a5ddb7823406b2a38cff6bb704b0acc289a09c8128d4a8ce2bbafcd1fcbdc38666422fe2806') \
 { echo 'Installer verified'; } \ 
else { echo 'Installer corrupt'; \ 
unlink('composer-setup.php'); } \ 
echo PHP_EOL;"
CHECKSUM
        if version == 'stable'

          install_result = shell_out "php composer-setup.php --install-dir=#{@composer_path}"
        else
          install_result = shell_out "php composer-setup.php --install-dir=#{@composer_path} --version=#{version}"
        end
        remove_installer_result = shell_out 'php -r "unlink(\'composer-setup.php\');"'
        unless get_installer_result and checksum_result and install_result and remove_installer_result
          raise RuntimeError 'Unable to install composer'
        end
      end

      def current_composer_version
        unless is_composer_installed?
          @composer_path
        end
      end
    end
  end
  module CliHelper
    class << self
      def install_laravel_cli
        LaravelProject::Helpers.check_for_windows!
        composer_helper = ComposerHelper
        if composer_helper.is_composer_installed?
          install_command = composer_helper.composer_path
        else
          install_command = composer_helper.install_composer_phar
        end
        shell_out "#{install_command} global require laravel/installer"
      end
    end
  end

end