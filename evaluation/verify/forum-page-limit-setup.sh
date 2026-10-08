#!/usr/bin/env bash
# Introspection SETUP: set the Forum "topics per page" (forum.settings:topics.page_limit)
# to a KNOWN non-default value (40) so an inspecting agent can read it back.
# Default is 25. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("forum.settings")->set("topics.page_limit", 40)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: forum.settings topics.page_limit set to 40"
