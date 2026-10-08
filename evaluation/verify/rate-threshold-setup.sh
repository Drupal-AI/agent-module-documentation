#!/usr/bin/env bash
# Introspection SETUP: set a distinctive per-minute bot threshold on rate.settings so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("rate.settings")->set("bot_minute_threshold", "7")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rate.settings bot_minute_threshold=7"
