#!/usr/bin/env bash
# Introspection CLEANUP: restore acquia_dam.settings domain to shipped default '' (disconnected).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("acquia_dam.settings")->set("domain","")->save();' >/dev/null 2>&1
echo "cleanup: acquia_dam.settings domain restored to ''"
