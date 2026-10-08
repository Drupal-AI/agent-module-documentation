#!/usr/bin/env bash
# Execution CLEANUP: same as reset (uninstall before removing directory). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall block_form_alter_eval_type -y >/dev/null 2>&1
rm -rf web/modules/custom/block_form_alter_eval_type
drush cr >/dev/null 2>&1
echo "cleanup: block_form_alter_eval_type removed"
