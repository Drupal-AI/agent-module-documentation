#!/usr/bin/env bash
# Execution RESET: restore NG Lightbox presentation defaults (no custom class, 700px,
# admin paths skipped) so the verify below fails on empty state. Idempotent. Exit 0.
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
echo "reset: lightbox_class='' default_width=700 skip_admin_paths=TRUE"
