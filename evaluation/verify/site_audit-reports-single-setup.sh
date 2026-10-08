#!/usr/bin/env bash
# Introspection SETUP: configure site_audit.settings so only the watchdog report is selected. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("site_audit.settings")
    ->set("reports", ["watchdog"=>"watchdog"])
    ->save();
' >/dev/null 2>&1
echo "setup: site_audit.settings reports = [watchdog]"
