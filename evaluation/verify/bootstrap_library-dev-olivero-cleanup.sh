#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped theme/minimized/cdn defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bootstrap_library.settings")
    ->set("minimized.options", TRUE)
    ->set("theme.visibility", TRUE)
    ->set("theme.themes", "")
    ->set("cdn.bootstrap", 0)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: bootstrap_library theme/minimized/cdn settings back to install defaults"
