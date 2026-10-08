#!/usr/bin/env bash
# Introspection SETUP: set the sharethis buttons location to 'links' (baseline is 'content')
# so the agent can read the current location. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("sharethis.settings")->set("location","links")->save();' >/dev/null 2>&1
echo "setup: sharethis.settings location=links"
