require 'spec/spec_helper'

describe 'helpers' do
  context 'Installs composer on Ubuntu' do
    platform 'ubuntu', VERSIONS::UBUNTU_VERSION
    it 'can install from composer.org' do
      expect { LaravelProject::ComposerHelper.install_composer_phar }.to_not raise_error
    end
  end

  context 'Installs composer on CentOS' do
    platform 'centos', VERSIONS::CENTOS_VERSION
    it 'can install from composer.org' do
      expect { LaravelProject::ComposerHelper.install_composer_phar }.to_not raise_error
    end
  end
end