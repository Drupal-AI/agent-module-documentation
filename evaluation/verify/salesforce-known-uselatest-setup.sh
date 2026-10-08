#!/usr/bin/env bash
# Introspection SETUP: disable "use latest REST API version" in salesforce.settings. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce.settings")->set("use_latest",false)->save();' >/dev/null 2>&1
echo "setup: salesforce.settings use_latest=false"
