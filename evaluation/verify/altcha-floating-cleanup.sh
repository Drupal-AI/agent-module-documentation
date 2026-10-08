#!/usr/bin/env bash
# medium CLEANUP (altcha): restore floating to shipped defaults (disabled, mode auto). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("altcha.settings")
    ->set("floating_enabled", FALSE)
    ->set("floating_mode", "auto")
    ->save();
' >/dev/null 2>&1
echo "cleanup: altcha.settings floating reset to defaults (disabled, auto)"
