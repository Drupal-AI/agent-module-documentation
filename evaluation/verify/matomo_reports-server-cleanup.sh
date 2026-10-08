#!/usr/bin/env bash
# Introspection CLEANUP: clear Matomo connection settings back to blank baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("matomo_reports.matomoreportssettings")
    ->set("matomo_server_url", "")
    ->set("matomo_reports_token_auth", "")
    ->save();
' >/dev/null 2>&1
echo "cleanup: matomo connection settings blanked"
