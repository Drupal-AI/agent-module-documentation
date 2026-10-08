#!/usr/bin/env bash
# Execution CLEANUP: restore baseline (module enabled). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install block_content_template -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block_content_template re-enabled (baseline)"
