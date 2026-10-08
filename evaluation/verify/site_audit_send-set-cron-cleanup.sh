#!/usr/bin/env bash
# Execution CLEANUP: reset cron_save_interval to 0 (baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("site_audit_send.settings")->set("cron_save_interval",0)->save();' >/dev/null 2>&1
echo "cleanup: cron_save_interval reset to 0"
