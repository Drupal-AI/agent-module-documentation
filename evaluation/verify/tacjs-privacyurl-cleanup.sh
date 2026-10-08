#!/usr/bin/env bash
# Introspection CLEANUP: restore dialog.privacyUrl to shipped baseline (empty string).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tacjs.settings")->set("dialog.privacyUrl","")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tacjs.settings dialog.privacyUrl=''"
