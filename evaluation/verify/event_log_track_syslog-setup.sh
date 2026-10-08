#!/usr/bin/env bash
# event_log_track_syslog introspection SETUP: set known event_log_track_syslog.settings (output_type=syslog, format marker ELT_SYSLOG_SENT). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("event_log_track_syslog.settings")->set("output_type","syslog")->set("format","ELT [[event-log:type]] [[event-log:ref_char]] [[event-log:operation]] ON [[event-log:path]] BY [user:[event-log:user:uid]:[event-log:user:name]:[event-log:user:roles:join:,]] [[event-log:description]] ELT_SYSLOG_SENT")->save();' >/dev/null 2>&1
echo "setup: event_log_track_syslog.settings output_type=syslog, format marked ELT_SYSLOG_SENT"
