#!/usr/bin/env bash
# Execution RESET: disable the Iubenda cookie solution and clear its siteId, so verify FAILS
# until the agent enables the banner and sets the siteId. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("iubenda_integration.settings")
    ->set("cookie_solution_enable", FALSE)
    ->set("siteId", "")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: iubenda_integration.settings cookie_solution_enable=false siteId=''"
