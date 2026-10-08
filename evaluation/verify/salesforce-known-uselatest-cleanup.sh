#!/usr/bin/env bash
# Introspection CLEANUP: restore use_latest to shipped default true. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce.settings")->set("use_latest",true)->save();' >/dev/null 2>&1
echo "cleanup: use_latest restored to true"
