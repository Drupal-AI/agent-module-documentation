#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped bootstrap_library theme/minimized defaults.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bootstrap_library.settings")
    ->set("theme.visibility", TRUE)
    ->set("theme.themes", "")
    ->set("minimized.options", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: bootstrap_library theme/minimized settings restored to install defaults"
