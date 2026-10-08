#!/usr/bin/env bash
# Execution CLEANUP: delete media_duplicates.settings (restore baseline absent). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_duplicates.settings")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media_duplicates.settings deleted (baseline)"
