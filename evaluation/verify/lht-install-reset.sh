#!/usr/bin/env bash
# Execution RESET: ensure label_help_test is uninstalled so the fixture content type does NOT exist
# (verify must FAIL until the agent installs it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall label_help_test -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: label_help_test uninstalled"
