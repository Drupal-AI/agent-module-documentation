#!/usr/bin/env bash
# Execution RESET: restore defaults (cron disabled, time_to_keep=null) so verify FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("maillog.settings")
    ->set("send", TRUE)->set("nosend_notify", FALSE)->set("log", TRUE)->set("log_notify", FALSE)
    ->set("verbose", TRUE)->set("body_trimmed", FALSE)->set("base64_remove", FALSE)
    ->set("cron_enabled", FALSE)->set("keep_limit_type", "time_to_keep")
    ->set("time_to_keep", NULL)->set("number_to_keep", NULL)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: maillog.settings defaults (cron_enabled=false)"
