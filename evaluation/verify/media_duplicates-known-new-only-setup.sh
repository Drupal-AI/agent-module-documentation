#!/usr/bin/env bash
# Introspection SETUP: restrict duplicates, only for NEW media. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_duplicates.settings")
    ->set("restrict_duplicates", TRUE)
    ->set("restrict_new_media_only", TRUE)
    ->set("compare_within_bundle_only", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: restrict_duplicates=1 restrict_new_media_only=1 compare_within_bundle_only=0"
