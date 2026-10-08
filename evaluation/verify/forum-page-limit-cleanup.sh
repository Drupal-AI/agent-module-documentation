#!/usr/bin/env bash
# Introspection CLEANUP: restore forum.settings topics.page_limit to its install default (25).
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("forum.settings")->set("topics.page_limit", 25)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: forum.settings topics.page_limit restored to 25"
