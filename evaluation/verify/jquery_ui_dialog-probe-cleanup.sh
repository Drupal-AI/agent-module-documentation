#!/usr/bin/env bash
# Introspection CLEANUP: uninstall the jqd_probe fixture module BEFORE deleting its directory
# (an enabled module with a missing directory makes the kernel fatal), then remove the files.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu jqd_probe -y >/dev/null 2>&1
rm -rf web/modules/custom/jqd_probe
drush cr >/dev/null 2>&1
echo "cleanup: jqd_probe uninstalled and removed"
