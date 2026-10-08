#!/usr/bin/env bash
# Introspection SETUP: set system.site name to a known value shown by Better Login. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("system.site")->set("name", "BetterloginQA Portal")->save();' >/dev/null 2>&1
echo "setup: system.site name='BetterloginQA Portal'"
