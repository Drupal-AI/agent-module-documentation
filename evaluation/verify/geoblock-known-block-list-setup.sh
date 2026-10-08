#!/usr/bin/env bash
# Introspection SETUP: set geoblock to block RU, CN, KP so an agent can read the live block
# list and mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("geoblock.settings")
    ->set("restriction_type", "block")
    ->set("restriction_country_codes", ["RU", "CN", "KP"])
    ->save();
' >/dev/null 2>&1
echo "setup: geoblock blocks RU, CN, KP"
