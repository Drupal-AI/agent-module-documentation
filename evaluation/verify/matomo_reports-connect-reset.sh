#!/usr/bin/env bash
# Execution RESET/CLEANUP: blank the Matomo server URL + token so verify FAILS until the agent
# configures them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("matomo_reports.matomoreportssettings")
    ->set("matomo_server_url", "")
    ->set("matomo_reports_token_auth", "")
    ->save();
' >/dev/null 2>&1
echo "reset: matomo_server_url and token blanked"
