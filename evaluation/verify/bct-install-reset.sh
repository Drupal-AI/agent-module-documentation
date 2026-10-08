#!/usr/bin/env bash
# Execution RESET: uninstall block_content_template so custom blocks do NOT use its template
# (verify must FAIL until the agent installs it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall block_content_template -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block_content_template uninstalled"
