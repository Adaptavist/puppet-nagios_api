# nagios_api Module

## Overview

The **nagios_api** module handles the configuration of [nagios-api](https://github.com/zorkian/nagios-api) 

### Configuration


- `$nagios_api_service` - nagios-api service name, defaults to nagios-api
- `$nagios_api_service_provider` - os dependent service provider, see params.pp for default
- `$nagios_api_package` - nagios-api package name
- `$nagios_api_port` - port for REST api
- `$package_deps` - apt/yum dependencies
- `$nagios_api_deps` - python packages required for nagios-api
- `$nagios_status_file_option` - -s file, nagios-api option, where file is path to nagios status file
- `$nagios_log_file_option` - -l file, nagios-api option, where file is path to nagios log file
- `$nagios_command_file_option`- -c file, nagios-api option, where file is path to nagios command file
- `$nagios_api_service_file` - service file, see params.pp for default
- `$nagios_api_service_template` - path to service file template, see params.pp for default
- `$nagios_api_binary` - nagios-api executable location

##Hiera Examples:

    nagios_api::nagios_api::port: '8082'    

## Dependencies

This module depends on the puppetlabs/stdlib module.
