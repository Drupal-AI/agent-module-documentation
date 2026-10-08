#!/usr/bin/env bash
# Introspection CLEANUP: restore global_push_limit to shipped default 100000. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce.settings")->set("global_push_limit",100000)->save();' >/dev/null 2>&1
echo "cleanup: global_push_limit restored to 100000"
