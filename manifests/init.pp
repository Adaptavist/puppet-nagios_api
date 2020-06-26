class nagios_api(
    $nagios_api_service          = $nagios_api::params::nagios_api_service,
    $nagios_api_service_provider = $nagios_api::params::nagios_api_service_provider,
    $nagios_api_package          = $nagios_api::params::nagios_api_package,
    $nagios_api_port             = $nagios_api::params::nagios_api_port,
    $package_deps                = $nagios_api::params::package_deps,
    $nagios_api_deps             = $nagios_api::params::nagios_api_deps,
    $nagios_status_file_option   = $nagios_api::params::nagios_status_file_option,
    $nagios_log_file_option      = $nagios_api::params::nagios_log_file_option,
    $nagios_command_file_option  = $nagios_api::params::nagios_command_file_option,
    $nagios_api_service_file     = $nagios_api::params::nagios_api_service_file,
    $nagios_api_service_template = $nagios_api::params::nagios_api_service_template,
    $nagios_api_binary           = $nagios_api::params::nagios_api_binary,
    ) inherits nagios_api::params {

    package { $package_deps:
        ensure => installed,
    } -> package { $nagios_api_deps:
        ensure   => installed,
        provider => pip,
    } -> package { $nagios_api_package:
        ensure   => installed,
        provider => pip,
    }

    $nagios_api_start_command = "${nagios_api_binary} -p ${nagios_api_port} ${nagios_command_file_option} ${nagios_log_file_option} ${nagios_status_file_option}"

    # ensure the directory that will house the host config files exists
    file { $nagios_api_service_file:
        content => template("${module_name}/${nagios_api_service_template}"),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package[$nagios_api_package],
    } -> service { $nagios_api_service:
        ensure     => running,
        provider   => $nagios_api_service_provider,
        enable     => true,
        hasrestart => false,
        hasstatus  => false,
    }
}
