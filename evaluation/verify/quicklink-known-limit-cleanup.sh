#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default total_request_limit=0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("quicklink.settings")->set("total_request_limit", 0)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: quicklink.settings total_request_limit restored to 0"
