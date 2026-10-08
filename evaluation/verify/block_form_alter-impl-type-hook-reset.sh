#!/usr/bin/env bash
# Execution RESET: uninstall + remove any block_form_alter_eval_type module so verify FAILS on
# empty state. Uninstall BEFORE deleting the directory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall block_form_alter_eval_type -y >/dev/null 2>&1
rm -rf web/modules/custom/block_form_alter_eval_type
drush cr >/dev/null 2>&1
echo "reset: block_form_alter_eval_type removed"
