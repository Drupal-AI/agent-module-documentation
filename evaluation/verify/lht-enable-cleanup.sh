#!/usr/bin/env bash
# Introspection CLEANUP: uninstall label_help_test to restore baseline (was not enabled). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall label_help_test -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: label_help_test uninstalled (baseline)"
