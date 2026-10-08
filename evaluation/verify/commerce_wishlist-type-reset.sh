#!/usr/bin/env bash
# Execution RESET: ensure the cw_gift wishlist type does NOT exist so verify FAILS until built. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("commerce_wishlist_type"); if($t=$s->load("cw_gift")){$t->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: commerce_wishlist_type cw_gift removed"
