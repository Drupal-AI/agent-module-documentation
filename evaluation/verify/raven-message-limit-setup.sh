#!/usr/bin/env bash
# MEDIUM introspection setup: store a KNOWN message_limit in raven.settings.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("raven.settings")
    ->set("message_limit", 512)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: raven.settings message_limit = 512"
