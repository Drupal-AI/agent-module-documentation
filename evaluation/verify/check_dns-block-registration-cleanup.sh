#!/usr/bin/env bash
# Execution CLEANUP (check_dns): restore baseline by ensuring check_dns is enabled
# (it ships enabled for this campaign). Exit 0.
set -uo pipefail
cd /var/www/html
drush -y en check_dns >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: check_dns re-enabled (baseline restored)"
