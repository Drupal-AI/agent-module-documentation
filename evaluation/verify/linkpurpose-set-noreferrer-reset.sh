#!/usr/bin/env bash
# Execution RESET: force purposeExternalNoReferrer off so verify FAILS until the agent enables it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("linkpurpose.settings")->set("purposeExternalNoReferrer", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: linkpurpose.settings purposeExternalNoReferrer=false"
