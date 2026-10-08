#!/usr/bin/env bash
# Introspection SETUP: set the Forum "hot topic" reply threshold
# (forum.settings:topics.hot_threshold) to a KNOWN non-default value (42) so an inspecting
# agent can read it back. Default is 15. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("forum.settings")->set("topics.hot_threshold", 42)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: forum.settings topics.hot_threshold set to 42"
