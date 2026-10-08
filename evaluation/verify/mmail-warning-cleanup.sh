#!/usr/bin/env bash
# Execution CLEANUP: uninstall monitoring_mail (baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall monitoring_mail -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: monitoring_mail uninstalled (baseline)"
