#!/usr/bin/env bash
# Execution CLEANUP: remove the cw_gift wishlist type. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("commerce_wishlist_type"); if($t=$s->load("cw_gift")){$t->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: commerce_wishlist_type cw_gift removed"
