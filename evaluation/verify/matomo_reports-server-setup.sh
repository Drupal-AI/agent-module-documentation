#!/usr/bin/env bash
# Introspection SETUP: configure a known Matomo server URL + global token. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("matomo_reports.matomoreportssettings")
    ->set("matomo_server_url", "https://matomo-known.example.com/matomo/")
    ->set("matomo_reports_token_auth", "abc123knowntoken")
    ->save();
' >/dev/null 2>&1
echo "setup: matomo_server_url=https://matomo-known.example.com/matomo/ token set"
