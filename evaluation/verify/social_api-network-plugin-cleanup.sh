#!/usr/bin/env bash
# Execution CLEANUP: same as the reset. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall social_api_eval_net -y >/dev/null 2>&1
rm -rf web/modules/custom/social_api_eval_net
drush cr >/dev/null 2>&1
echo "cleanup: social_api_eval_net module removed"
