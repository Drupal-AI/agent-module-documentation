#!/usr/bin/env bash
# Execution CLEANUP: same as reset (uninstall before removing directory). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall pluginformalter_eval -y >/dev/null 2>&1
rm -rf web/modules/custom/pluginformalter_eval
drush cr >/dev/null 2>&1
echo "cleanup: pluginformalter_eval removed"
