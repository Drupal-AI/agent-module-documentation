#!/usr/bin/env bash
# Introspection SETUP: configure a floor of 900 seconds with no ceiling, so a page that
# bubbles a short max-age is raised to 900. The agent must read the live config and apply
# the module's clamping rules. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cache_control_override.settings")
    ->set("max_age.minimum", 900)
    ->set("max_age.maximum", -1)
    ->save();
' >/dev/null 2>&1
echo "setup: cache_control_override.settings max_age.minimum=900 max_age.maximum=-1"
