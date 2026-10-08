#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default login_destination=/user/%user/edit. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("prlp.settings")->set("login_destination", "/user/%user/edit")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: login_destination restored to /user/%user/edit"
