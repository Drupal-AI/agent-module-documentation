#!/usr/bin/env bash
# MEDIUM introspection cleanup: restore raven.settings environment to its install default (null).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("raven.settings")
    ->set("environment", NULL)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: raven.settings environment restored to null"
