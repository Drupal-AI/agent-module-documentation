#!/usr/bin/env bash
# Introspection CLEANUP: restore onlyone_redirect to its shipped default (true). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("onlyone.settings")->set("onlyone_redirect", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: onlyone.settings onlyone_redirect restored to true"
