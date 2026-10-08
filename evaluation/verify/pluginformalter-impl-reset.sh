#!/usr/bin/env bash
# Execution RESET: uninstall + remove any pluginformalter_eval module so verify FAILS on
# empty state. Uninstall BEFORE deleting the directory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall pluginformalter_eval -y >/dev/null 2>&1
rm -rf web/modules/custom/pluginformalter_eval
drush cr >/dev/null 2>&1
echo "reset: pluginformalter_eval removed"
