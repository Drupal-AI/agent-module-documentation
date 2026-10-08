#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped defaults for the touched keys. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("iubenda_integration.settings")
    ->set("cookie_solution_enable", FALSE)
    ->set("siteId", "")
    ->set("position", "full-top")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: iubenda_integration.settings cookie solution keys restored to defaults"
