require 'spec_helper'
 
describe 'nagios_api', :type => 'class' do
  
  context "Should install dependencies, package and service on ubuntu" do
    let(:facts){{
      :osfamily => 'Debian',
      :lsbdistid => 'Ubuntu',
      :lsbdistcodename => 'precise',
    }}
    it do
      should contain_package('libssl-dev').with(
        'ensure' => 'installed',
      )
      should contain_package('diesel').with(
        'ensure' => 'installed',
        'provider' => 'pip',
      )
      should contain_package('greenlet').with(
        'ensure' => 'installed',
        'provider' => 'pip',
      )
      should contain_package('pyopenssl').with(
        'ensure' => 'installed',
        'provider' => 'pip',
      )
      should contain_package('nagios-api').with(
        'ensure' => 'installed',
        'provider' => 'pip',
      )
      
      should contain_file('/etc/init/nagios-api.conf').with(
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
        'require' => 'Package[nagios-api]',
      ).with_content(/nagios-api -p 8081 -c \/var\/lib\/nagios3\/rw\/nagios.cmd -l \/var\/log\/nagios3\/nagios.log -s \/var\/log\/nagios3\/status.dat/)
      should contain_service('nagios-api').with(
        'ensure'     => 'running',
        'provider'   => 'upstart',
        'enable'     => 'true',
        'hasrestart' => 'false',
        'hasstatus'  => 'false',
      )
    end
  end
  context "Should install dependencies, package and service on centos" do
    let(:facts){{
      :osfamily => 'RedHat',
      :operatingsystem => 'Centos',
      :lsbdistid => 'Centos',
    }}
    it do
      should contain_package('openssl-devel').with(
        'ensure' => 'installed',
      )
      should contain_package('diesel').with(
        'ensure' => 'installed',
        'provider' => 'pip',
      )
      should contain_package('greenlet').with(
        'ensure' => 'installed',
        'provider' => 'pip',
      )
      should contain_package('pyopenssl').with(
        'ensure' => 'installed',
        'provider' => 'pip',
      )
      should contain_package('nagios-api').with(
        'ensure' => 'installed',
        'provider' => 'pip',
      )
      
      should contain_file('/etc/init/nagios-api.conf').with(
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
        'require' => 'Package[nagios-api]',
      ).with_content(/nagios-api -p 8081 -c \/var\/lib\/nagios3\/rw\/nagios.cmd -l \/var\/log\/nagios3\/nagios.log -s \/var\/log\/nagios3\/status.dat/)
      should contain_service('nagios-api').with(
        'ensure'     => 'running',
        'provider'   => 'upstart',
        'enable'     => 'true',
        'hasrestart' => 'false',
        'hasstatus'  => 'false',
      )
    end
  end

  context "Should install dependencies, package and systemd service on centos 7" do
    let(:facts){{
      :osfamily => 'RedHat',
      :operatingsystem => 'Centos',
      :distrelease => '7',
      :lsbdistid => 'Centos',
    }}
    it do
      should contain_package('openssl-devel').with(
        'ensure' => 'installed',
      )
      should contain_package('diesel').with(
        'ensure' => 'installed',
        'provider' => 'pip',
      )
      should contain_package('greenlet').with(
        'ensure' => 'installed',
        'provider' => 'pip',
      )
      should contain_package('pyopenssl').with(
        'ensure' => 'installed',
        'provider' => 'pip',
      )
      should contain_package('nagios-api').with(
        'ensure' => 'installed',
        'provider' => 'pip',
      )
      
      should contain_file('/etc/systemd/system/nagios-api.service').with(
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
        'require' => 'Package[nagios-api]',
      ).with_content(/nagios-api -p 8081 -c \/var\/lib\/nagios3\/rw\/nagios.cmd -l \/var\/log\/nagios3\/nagios.log -s \/var\/log\/nagios3\/status.dat/)
      should contain_service('nagios-api').with(
        'ensure'     => 'running',
        'provider'   => 'systemd',
        'enable'     => 'true',
        'hasrestart' => 'false',
        'hasstatus'  => 'false',
      )
    end
  end
end

