#!/usr/bin/env bash
# Execution CLEANUP: restore purposeExternalNewWindow to shipped default false.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("linkpurpose.settings")->set("purposeExternalNewWindow", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: linkpurpose.settings purposeExternalNewWindow restored to false"
