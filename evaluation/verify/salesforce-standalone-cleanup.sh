#!/usr/bin/env bash
# Execution CLEANUP: restore standalone to shipped default false. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce.settings")->set("standalone",false)->save();' >/dev/null 2>&1
echo "cleanup: standalone restored to false"
