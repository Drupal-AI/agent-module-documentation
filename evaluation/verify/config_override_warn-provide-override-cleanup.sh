#!/usr/bin/env bash
# Execution CLEANUP: uninstall and delete the cow_eval_task override-provider module the agent
# was asked to create, restoring an override-free system.site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu cow_eval_task -y >/dev/null 2>&1
rm -rf web/modules/custom/cow_eval_task
drush cr >/dev/null 2>&1
echo "cleanup: cow_eval_task removed"
