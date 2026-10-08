#!/usr/bin/env bash
# Execution RESET: set cron_save_interval to 0 (never) so verify FAILS until the agent sets it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("site_audit_send.settings")->set("cron_save_interval",0)->save();' >/dev/null 2>&1
echo "reset: cron_save_interval = 0"
