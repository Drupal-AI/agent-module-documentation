#!/usr/bin/env bash
# Execution RESET: restore maximum_records to the shipped default (250). verify FAILS until the
# agent sets it to 500. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set auditfiles.settings auditfiles_report_options_maximum_records 250 -y >/dev/null 2>&1
echo "reset: auditfiles_report_options_maximum_records=250 (default)"
