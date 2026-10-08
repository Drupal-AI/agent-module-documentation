#!/usr/bin/env bash
# Execution RESET: delete media_duplicates.settings so all restriction flags are absent/FALSE and
# verify FAILS until the agent turns them on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_duplicates.settings")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media_duplicates.settings deleted (all flags off)"
