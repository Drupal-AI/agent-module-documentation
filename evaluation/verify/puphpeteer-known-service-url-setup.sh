#!/usr/bin/env bash
# Introspection SETUP: puphpeteer is disabled, so create its config object with a known
# external-service URL for the agent to read back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("puphpeteer.settings")
    ->set("service", TRUE)->set("service_url", "http://chrome:9222")->save();
' >/dev/null 2>&1
echo "setup: puphpeteer.settings service=true service_url=http://chrome:9222"
