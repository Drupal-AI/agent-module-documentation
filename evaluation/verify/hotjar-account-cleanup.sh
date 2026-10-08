#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default (account empty).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("hotjar.settings")->set("account","")->save();' >/dev/null 2>&1
echo "cleanup: hotjar.settings account restored to ''"
