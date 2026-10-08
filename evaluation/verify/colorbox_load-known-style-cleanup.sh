#!/usr/bin/env bash
# Introspection CLEANUP: restore ng_lightbox.settings styling defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ng_lightbox.settings")
    ->set("lightbox_class", "")
    ->set("default_width", 700)
    ->set("skip_admin_paths", TRUE)
    ->set("renderer", "drupal_colorbox")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ng_lightbox.settings styling restored (class='', width=700, skip_admin_paths=true)"
