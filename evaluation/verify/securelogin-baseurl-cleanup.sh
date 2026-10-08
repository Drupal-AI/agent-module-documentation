#!/usr/bin/env bash
# Introspection CLEANUP: restore base_url to its shipped baseline (null). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("securelogin.settings")->set("base_url",NULL)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: securelogin.settings base_url=null"
