#!/usr/bin/env bash
# Introspection CLEANUP: uninstall and delete the probe module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall social_api_eval_probe -y >/dev/null 2>&1
rm -rf web/modules/custom/social_api_eval_probe
drush cr >/dev/null 2>&1
echo "cleanup: social_api_eval_probe removed"
