#!/usr/bin/env bash
# Execution RESET: restore cache_control_override.settings to the module's shipped defaults
# (max_age.minimum 0, max_age.maximum -1 = clamping disabled), so verify FAILS until the
# agent configures the requested floor and ceiling. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cache_control_override.settings")
    ->set("max_age.minimum", 0)
    ->set("max_age.maximum", -1)
    ->save();
' >/dev/null 2>&1
echo "reset: cache_control_override.settings back to defaults (minimum 0, maximum -1)"
