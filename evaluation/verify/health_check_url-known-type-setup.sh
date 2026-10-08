#!/usr/bin/env bash
# Introspection SETUP (health_check_url): set a known response type + string so an agent can read
# which response format is configured. Config-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("health_check_url.settings")
    ->set("type", "stringWithTimestamp")->set("string", "OK-HCU")
    ->set("endpoint", "/health")->set("maintainence_access", FALSE)->save();
' >/dev/null 2>&1 || true
echo "setup: health_check_url.settings type=stringWithTimestamp string=OK-HCU"
exit 0
