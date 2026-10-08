#!/usr/bin/env bash
# Introspection CLEANUP: restore cdn to its shipped default (false). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("phone_international.settings")->set("cdn", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: phone_international.settings.cdn = false"
