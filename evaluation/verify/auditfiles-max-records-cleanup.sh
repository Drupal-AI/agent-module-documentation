#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush config:set auditfiles.settings auditfiles_report_options_maximum_records 250 -y >/dev/null 2>&1
echo "cleanup: auditfiles_report_options_maximum_records restored to 250"
