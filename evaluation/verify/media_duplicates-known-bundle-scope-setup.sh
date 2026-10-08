#!/usr/bin/env bash
# Introspection SETUP: restrict duplicates, compare within same bundle only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_duplicates.settings")
    ->set("restrict_duplicates", TRUE)
    ->set("restrict_new_media_only", FALSE)
    ->set("compare_within_bundle_only", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: restrict_duplicates=1 compare_within_bundle_only=1"
