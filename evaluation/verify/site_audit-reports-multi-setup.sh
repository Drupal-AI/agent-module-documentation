#!/usr/bin/env bash
# Introspection SETUP: configure site_audit.settings so the audit page is limited to the
# cache and security reports. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("site_audit.settings")
    ->set("reports", ["cache"=>"cache", "security"=>"security"])
    ->save();
' >/dev/null 2>&1
echo "setup: site_audit.settings reports = [cache, security]"
