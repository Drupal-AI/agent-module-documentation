#!/usr/bin/env bash
# Execution RESET: uninstall easy_encryption_admin so verify FAILS until it is re-enabled.
set -uo pipefail
cd /var/www/html
drush pmu easy_encryption_admin -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: easy_encryption_admin uninstalled"
