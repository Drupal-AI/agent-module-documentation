#!/usr/bin/env bash
# Introspection SETUP: create puphpeteer.settings with headless=FALSE (non-default) so the
# agent can inspect and report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("puphpeteer.settings")->set("headless", FALSE)->save();
' >/dev/null 2>&1
echo "setup: puphpeteer.settings headless=false"
