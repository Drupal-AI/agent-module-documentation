#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce.settings")->set("salesforce_auth_provider","")->save();' >/dev/null 2>&1
echo "reset: salesforce_auth_provider=''"
