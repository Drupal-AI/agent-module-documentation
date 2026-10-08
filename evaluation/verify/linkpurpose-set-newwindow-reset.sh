#!/usr/bin/env bash
# Execution RESET: force purposeExternalNewWindow off so verify FAILS until the agent enables it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("linkpurpose.settings")->set("purposeExternalNewWindow", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: linkpurpose.settings purposeExternalNewWindow=false"
