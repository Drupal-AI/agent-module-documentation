#!/usr/bin/env bash
# Execution RESET: clear excluded_paths (empty) so verify (which expects /api/*) FAILS until the
# agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("single_language_url_prefix.settings")->set("excluded_paths", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: excluded_paths empty"
