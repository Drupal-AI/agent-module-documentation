#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default location 'content'.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("sharethis.settings")->set("location","content")->save();' >/dev/null 2>&1
echo "cleanup: sharethis.settings location restored to content"
