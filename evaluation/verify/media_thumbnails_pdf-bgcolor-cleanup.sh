#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (bgcolor_active false, bgcolor_value #eeeeee).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_thumbnails.settings")
    ->set("bgcolor_active", FALSE)->set("bgcolor_value", "#eeeeee")->save();
' >/dev/null 2>&1
echo "cleanup: media_thumbnails.settings background restored (false / #eeeeee)"
