#!/usr/bin/env bash
# Introspection CLEANUP: remove the cg_holiday gift-card type config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_giftcard.giftcard_type.cg_holiday")->delete();' >/dev/null 2>&1
echo "cleanup: commerce_giftcard.giftcard_type.cg_holiday removed"
