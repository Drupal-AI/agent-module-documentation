#!/usr/bin/env bash
# Introspection SETUP: set a distinctive cron_send_interval in site_audit_send.settings. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("site_audit_send.settings")->set("cron_send_interval",3600)->save();
' >/dev/null 2>&1
echo "setup: site_audit_send.settings cron_send_interval = 3600"
