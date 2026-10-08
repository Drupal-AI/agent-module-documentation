#!/usr/bin/env bash
# Introspection SETUP: set the site-wide TimelineJS library location to a known non-default
# value (cdn_3.8.18) so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("views_timelinejs.settings")->set("library_location", "cdn_3.8.18")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: views_timelinejs.settings:library_location = cdn_3.8.18"
