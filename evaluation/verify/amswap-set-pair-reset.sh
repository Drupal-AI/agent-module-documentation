#!/usr/bin/env bash
# Execution RESET: ensure role amswap_task exists and amswap has NO role-menu pairs, so verify
# FAILS until the agent maps amswap_task to the 'tools' menu. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create amswap_task "Amswap Task" >/dev/null 2>&1 || true
drush php:eval '\Drupal::configFactory()->getEditable("amswap.amswapconfig")->set("role_menu_pairs", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role amswap_task present, amswap.amswapconfig role_menu_pairs=[]"
