#!/usr/bin/env bash
# Introspection SETUP: put a known, non-default clamp configuration into
# cache_control_override.settings (floor 0, ceiling 120) so the agent can read the live
# ceiling off the running site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cache_control_override.settings")
    ->set("max_age.minimum", 0)
    ->set("max_age.maximum", 120)
    ->save();
' >/dev/null 2>&1
echo "setup: cache_control_override.settings max_age.minimum=0 max_age.maximum=120"
