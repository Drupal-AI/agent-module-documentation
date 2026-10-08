#!/usr/bin/env bash
# Introspection SETUP: restrict reports to a known allowed-sites whitelist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("matomo_reports.matomoreportssettings")
    ->set("matomo_reports_allowed_sites", "2,5,9")->save();
' >/dev/null 2>&1
echo "setup: matomo_reports_allowed_sites=2,5,9"
