#!/usr/bin/env bash
# Execution RESET: clear the CookiePro script config so verify FAILS on empty state until the
# agent configures the consent script. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cookiepro.header.settings")->delete();
' >/dev/null 2>&1
echo "reset: cookiepro.header.settings cleared"
