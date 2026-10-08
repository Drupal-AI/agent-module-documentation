#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore event_log_track deletion settings to shipped defaults
# (enable_log_deletion=false, timespan_limit=30) so verify FAILS until the agent changes them. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("event_log_track.settings")->set("enable_log_deletion",FALSE)->set("timespan_limit",30)->save();' >/dev/null 2>&1
echo "reset: enable_log_deletion=false, timespan_limit=30"
