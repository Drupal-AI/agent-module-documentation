#!/usr/bin/env bash
# Introspection SETUP: turn ON "accept T&Cs on every login" so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("legal.settings")->set("accept_every_login", TRUE)->save();' >/dev/null 2>&1
echo "setup: legal.settings accept_every_login=TRUE"
