#!/usr/bin/env bash
# MEDIUM introspection cleanup: restore message_limit to its install default (2048).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("raven.settings")
    ->set("message_limit", 2048)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: raven.settings message_limit restored to 2048"
