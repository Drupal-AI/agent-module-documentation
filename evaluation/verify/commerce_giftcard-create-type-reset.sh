#!/usr/bin/env bash
# Execution RESET: ensure gift-card type cg_task does NOT exist so verify FAILS until created. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_giftcard.giftcard_type.cg_task")->delete();' >/dev/null 2>&1
echo "reset: commerce_giftcard.giftcard_type.cg_task removed"
