#!/usr/bin/env bash
# CLEANUP/RESET: restore the shipped media_thumbnails.settings defaults consumed by the SVG
# thumbnail plugin (width 500, bgcolor_active false, bgcolor_value #eeeeee). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("media_thumbnails.settings");
  $c->set("width", 500)->set("bgcolor_active", FALSE)->set("bgcolor_value", "#eeeeee")->save();
' >/dev/null 2>&1
echo "restore: media_thumbnails.settings width=500 bgcolor_active=false bgcolor_value=#eeeeee"
