# Class: java::params
#
# This class sets the value of two variables, jdk_package and jre_package,
# appropriate for the client system in question.
#
class nagios_api::params {
    $nagios_api_port = '8081'
    $nagios_api_package = 'nagios-api'
    $nagios_api_service = 'nagios-api'
    case $::osfamily {
        default: { fail("unsupported platform ${::osfamily}") }
        'RedHat': {
            if ($::operatingsystem == 'Fedora' and versioncmp($::distrelease, '18') >= 0) or ($::operatingsystem != 'Fedora' and versioncmp($::distrelease, '7') >= 0) {
                # systemd
                $nagios_api_service_template = 'systemd/systemd.service.erb'
                $nagios_api_service_file = '/etc/systemd/system/nagios-api.service'
                $nagios_api_service_provider = 'systemd'
            } else {
                # upstart
                $nagios_api_service_template = 'upstart/upstart-redhat.conf.erb'
                $nagios_api_service_file = '/etc/init/nagios-api.conf'
                $nagios_api_service_provider = 'upstart'
            }
            $package_deps = ['openssl-devel']
            $nagios_api_deps = ['diesel', 'greenlet', 'pyopenssl']
            $nagios_status_file_option = '-s /var/log/nagios3/status.dat'
            $nagios_log_file_option = '-l /var/log/nagios3/nagios.log'
            $nagios_command_file_option = '-c /var/lib/nagios3/rw/nagios.cmd'
            $nagios_api_binary = '/usr/local/bin/nagios-api'
        }
        'Debian': {
            $nagios_api_service_provider = 'upstart'
            $nagios_api_service_template = 'upstart/upstart-debian.conf.erb'
            $nagios_api_service_file = '/etc/init/nagios-api.conf'
            $package_deps = ['libssl-dev']
            $nagios_api_deps = ['diesel', 'greenlet', 'pyopenssl']
            $nagios_status_file_option = '-s /var/log/nagios3/status.dat'
            $nagios_log_file_option = '-l /var/log/nagios3/nagios.log'
            $nagios_command_file_option = '-c /var/lib/nagios3/rw/nagios.cmd'
            $nagios_api_binary = '/usr/local/bin/nagios-api'
        }
    }

}
