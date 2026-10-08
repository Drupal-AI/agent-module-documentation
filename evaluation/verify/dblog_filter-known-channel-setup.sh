#!/usr/bin/env bash
# Introspection SETUP: configure dblog_filter to EXCLUDE the 'cron' channel's info/notice/debug
# from the database log (method=exclude, log_values row cron|info,notice,debug) so an agent can
# read which channel is filtered. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("dblog_filter.settings");
  $c->set("method", "exclude")->set("log_values", ["cron|info,notice,debug"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: dblog_filter method=exclude, log_values=[cron|info,notice,debug]"
