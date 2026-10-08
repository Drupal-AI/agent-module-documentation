#!/usr/bin/env bash
# Introspection SETUP: enable the CDN option in phone_international.settings so the agent can
# read the live value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("phone_international.settings")->set("cdn", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: phone_international.settings.cdn = true"
