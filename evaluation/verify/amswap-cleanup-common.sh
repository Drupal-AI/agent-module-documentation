#!/usr/bin/env bash
# Shared CLEANUP: restore baseline amswap config (role_menu_pairs empty) and remove the
# amswap_reviewer test role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("amswap.amswapconfig")->set("role_menu_pairs", [])->save();' >/dev/null 2>&1
drush role:delete amswap_reviewer >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "cleanup: amswap.amswapconfig role_menu_pairs=[] ; role amswap_reviewer removed"
