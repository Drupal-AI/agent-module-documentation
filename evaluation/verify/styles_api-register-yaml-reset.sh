#!/usr/bin/env bash
# Execution RESET: uninstall + remove any styles_api_eval_yaml module so verify FAILS on empty
# state. Uninstall BEFORE deleting the directory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall styles_api_eval_yaml -y >/dev/null 2>&1
rm -rf web/modules/custom/styles_api_eval_yaml
drush cr >/dev/null 2>&1
echo "reset: styles_api_eval_yaml removed"
