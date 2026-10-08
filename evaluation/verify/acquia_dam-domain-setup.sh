#!/usr/bin/env bash
# Introspection SETUP: set a known DAM domain in acquia_dam.settings so an agent can read it
# back. Local config only (no DAM API call). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("acquia_dam.settings")->set("domain","eval-demo.widencollective.com")->save();' >/dev/null 2>&1
echo "setup: acquia_dam.settings domain=eval-demo.widencollective.com"
