#!/usr/bin/env bash
# Introspection CLEANUP: reset cron_send_interval to 0 (never). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("site_audit_send.settings")->set("cron_send_interval",0)->save();' >/dev/null 2>&1
echo "cleanup: cron_send_interval reset to 0"
