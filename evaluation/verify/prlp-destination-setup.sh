#!/usr/bin/env bash
# Introspection SETUP: set a distinctive PRLP login_destination so an agent can read where users
# are sent after a reset login. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("prlp.settings")->set("login_destination", "/prlp-landing")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: prlp.settings login_destination=/prlp-landing"
