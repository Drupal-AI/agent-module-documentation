#!/usr/bin/env bash
# medium SETUP (altcha): enable the floating/invisible widget anchored at the bottom. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("altcha.settings")
    ->set("floating_enabled", TRUE)
    ->set("floating_mode", "bottom")
    ->save();
' >/dev/null 2>&1
echo "setup: altcha.settings floating_enabled=true floating_mode=bottom"
