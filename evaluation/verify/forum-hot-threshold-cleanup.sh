#!/usr/bin/env bash
# Introspection CLEANUP: restore forum.settings topics.hot_threshold to its install default (15).
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("forum.settings")->set("topics.hot_threshold", 15)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: forum.settings topics.hot_threshold restored to 15"
