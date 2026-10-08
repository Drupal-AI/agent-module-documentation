#!/usr/bin/env bash
# Introspection SETUP: enable the Iubenda cookie solution with a known siteId and banner
# position so an inspecting agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("iubenda_integration.settings")
    ->set("cookie_solution_enable", TRUE)
    ->set("siteId", "44556677")
    ->set("position", "bottom")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: iubenda_integration.settings cookie_solution_enable=true siteId=44556677 position=bottom"
