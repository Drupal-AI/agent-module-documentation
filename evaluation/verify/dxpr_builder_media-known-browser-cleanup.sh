#!/usr/bin/env bash
# Introspection CLEANUP: restore the baseline media_browser value (empty string = basic file
# upload). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("dxpr_builder.settings")
    ->set("media_browser", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: dxpr_builder.settings media_browser restored to '' (basic file upload)"
