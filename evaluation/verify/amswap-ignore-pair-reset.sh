#!/usr/bin/env bash
# Execution RESET: ensure role amswap_task2 exists and amswap has NO role-menu pairs, so verify
# FAILS until the agent maps amswap_task2 to 'footer' with administrator in ignored_roles.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create amswap_task2 "Amswap Task 2" >/dev/null 2>&1 || true
drush php:eval '\Drupal::configFactory()->getEditable("amswap.amswapconfig")->set("role_menu_pairs", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role amswap_task2 present, amswap.amswapconfig role_menu_pairs=[]"
