#!/usr/bin/env bash
# Execution RESET: clear single_language_url_prefix.settings excluded_paths (empty) so verify (which
# expects /admin exclusions) FAILS until the agent sets them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("single_language_url_prefix.settings")->set("excluded_paths", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: excluded_paths empty"
