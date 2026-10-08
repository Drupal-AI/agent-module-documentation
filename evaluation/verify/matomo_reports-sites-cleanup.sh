#!/usr/bin/env bash
# Introspection CLEANUP: clear the allowed-sites whitelist. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("matomo_reports.matomoreportssettings")
    ->set("matomo_reports_allowed_sites", "")->save();
' >/dev/null 2>&1
echo "cleanup: matomo_reports_allowed_sites cleared"
