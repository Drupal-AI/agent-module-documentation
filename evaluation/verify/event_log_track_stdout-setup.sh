#!/usr/bin/env bash
# event_log_track_stdout introspection SETUP: set known event_log_track_stdout.settings (output_type=stdout, format marker ELT_STDOUT_SENT). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("event_log_track_stdout.settings")->set("output_type","stdout")->set("format","ELT [[event-log:type]] [[event-log:ref_char]] [[event-log:operation]] ON [[event-log:path]] BY [user:[event-log:user:uid]:[event-log:user:name]:[event-log:user:roles:join:,]] [[event-log:description]] ELT_STDOUT_SENT")->save();' >/dev/null 2>&1
echo "setup: event_log_track_stdout.settings output_type=stdout, format marked ELT_STDOUT_SENT"
