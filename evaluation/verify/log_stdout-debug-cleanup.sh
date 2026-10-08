#!/usr/bin/env bash
# Execution CLEANUP: restore severity_level=3 default. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y log_stdout.settings severity_level 3 >/dev/null 2>&1
echo "cleanup: log_stdout.settings severity_level=3"
