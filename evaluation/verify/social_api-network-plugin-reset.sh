#!/usr/bin/env bash
# Execution RESET: uninstall and delete any social_api_eval_net module the agent created, so
# verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall social_api_eval_net -y >/dev/null 2>&1
rm -rf web/modules/custom/social_api_eval_net
drush cr >/dev/null 2>&1
echo "reset: social_api_eval_net module removed, no eval Network plugin registered"
