#!/usr/bin/env bash
# Introspection CLEANUP: restore other_forms to its shipped baseline (empty list). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("securelogin.settings")->set("other_forms",[])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: securelogin.settings other_forms=[]"
