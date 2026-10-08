#!/usr/bin/env bash
# Execution RESET/CLEANUP: clear skip_patterns so verify FAILS until the agent sets it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("event_log_track.settings")->set("skip_patterns","")->save();' >/dev/null 2>&1
echo "reset: skip_patterns cleared"
