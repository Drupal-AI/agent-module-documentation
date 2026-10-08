#!/usr/bin/env bash
# HARD reset: clear the global entity_meta property list so verify FAILS; the
# agent must add the requested properties (uid + created).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("datalayer.settings")
    ->set("entity_meta", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: datalayer entity_meta = []"
