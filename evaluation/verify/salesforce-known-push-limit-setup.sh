#!/usr/bin/env bash
# Introspection SETUP: set a known global push queue limit in salesforce.settings. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce.settings")->set("global_push_limit",250)->save();' >/dev/null 2>&1
echo "setup: salesforce.settings global_push_limit=250"
