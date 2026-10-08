#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore mask_color to default #0678be so verify FAILS until agent sets
# #ff0000. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa_extras.settings.apple")->set("mask_color","#0678be")->save();' >/dev/null 2>&1
echo "reset: pwa_extras.settings.apple mask_color=#0678be (default)"
