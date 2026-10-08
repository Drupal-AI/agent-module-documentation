#!/usr/bin/env bash
# event_log_track_stdout restore: reset event_log_track_stdout.settings to defaults (output_type=watchdog, default format). Used as medium cleanup and hard reset/cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("event_log_track_stdout.settings")->set("output_type","watchdog")->set("format","ELT [[event-log:type]] [[event-log:ref_char]] [[event-log:operation]] ON [[event-log:path]] BY [user:[event-log:user:uid]:[event-log:user:name]:[event-log:user:roles:join:,]] [[event-log:description]]")->save();' >/dev/null 2>&1
echo "restore: event_log_track_stdout.settings output_type=watchdog, default format"
