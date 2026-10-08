#!/usr/bin/env bash
# Execution CLEANUP: restore baseline amswap config and remove the amswap_task role. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("amswap.amswapconfig")->set("role_menu_pairs", [])->save();' >/dev/null 2>&1
drush role:delete amswap_task >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "cleanup: amswap baseline restored; role amswap_task removed"
