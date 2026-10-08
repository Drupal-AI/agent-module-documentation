#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("registration_workflow.settings")->set("prevent_complete_own", FALSE)->save();' >/dev/null 2>&1
echo "cleanup: registration_workflow.settings prevent_complete_own restored to false"
