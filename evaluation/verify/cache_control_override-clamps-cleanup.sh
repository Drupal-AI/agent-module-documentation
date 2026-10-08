#!/usr/bin/env bash
# Introspection CLEANUP: restore the module's shipped defaults (minimum 0, maximum -1),
# i.e. clamping disabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cache_control_override.settings")
    ->set("max_age.minimum", 0)
    ->set("max_age.maximum", -1)
    ->save();
' >/dev/null 2>&1
echo "cleanup: cache_control_override.settings restored to defaults (0 / -1)"
