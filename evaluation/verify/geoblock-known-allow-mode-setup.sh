#!/usr/bin/env bash
# Introspection SETUP: set geoblock to an allow-list of US so an agent can identify the mode.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("geoblock.settings")
    ->set("restriction_type", "allow")
    ->set("restriction_country_codes", ["US"])
    ->save();
' >/dev/null 2>&1
echo "setup: geoblock allow-list US"
