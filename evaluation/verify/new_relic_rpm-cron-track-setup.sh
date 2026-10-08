#!/usr/bin/env bash
# Introspection SETUP: set cron transaction tracking to "ignore" so the agent can read the
# current track_cron value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("new_relic_rpm.settings")->set("track_cron", "ignore")->save();
' >/dev/null 2>&1
echo "setup: new_relic_rpm.settings track_cron=ignore"
