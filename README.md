# SNMP Counter Sub-Agent

The SNMP Counter Sub-Agent is a Perl script that serves as an SNMP sub-agent to provide counter values in response to SNMP GET requests.

## Description

This script implements a sub-agent using Net-SNMP to handle SNMP GET requests for specific counter values. It reads counter values from a configuration file, multiplies them by the current system time, and responds with the computed values.

## Prerequisites

- Perl (version 5.x or higher)
- Net-SNMP Perl module (NetSNMP::agent and related modules)
- SNMP client for testing (e.g., `snmpget` or SNMP management software)

## Installation

1. Install Perl if not already installed.
2. Install the required Perl module, Net-SNMP, using CPAN or any other package manager.
3. Save the `snmp_counter_subagent.pl` script to a suitable location.

## Usage

1. Ensure that the configuration file `/usr/share/snmp/counters.conf` exists and contains comma-separated key-value pairs for the counters.
2. Run the script: `perl snmp_counter_subagent.pl`
3. The sub-agent will be registered to handle SNMP GET requests for the root OID `.1.3.6.1.4.1.4171.40`.
4. You can now use an SNMP client to query for counter values:

`snmpget -v2c -c <community_string> localhost .1.3.6.1.4.1.4171.40.1`

This will retrieve the counter value multiplied by the current system time.

## Configuration

The script assumes the existence of the configuration file `/usr/share/snmp/counters.conf`, where each line contains a comma-separated key-value pair representing a counter value.

## Note

- This script is a basic example and might require adjustments based on specific use cases.
- Ensure that the configuration file is properly formatted with valid counter values.
