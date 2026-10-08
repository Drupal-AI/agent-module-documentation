#!/usr/bin/env bash
# Introspection CLEANUP: restore purposeTel to shipped default true.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("linkpurpose.settings")->set("purposeTel", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: linkpurpose.settings purposeTel restored to true"
