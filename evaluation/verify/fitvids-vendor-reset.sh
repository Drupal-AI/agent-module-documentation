#!/usr/bin/env bash
# Execution RESET: restore fitvids.settings custom_vendors/ignore_selectors to shipped
# defaults so verify FAILS until the agent adds the videopress vendor and slick ignore
# selector. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fitvids.settings")
    ->set("custom_vendors", "https://youtu.be")
    ->set("ignore_selectors", "")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: fitvids.settings custom_vendors=https://youtu.be ignore_selectors empty"
