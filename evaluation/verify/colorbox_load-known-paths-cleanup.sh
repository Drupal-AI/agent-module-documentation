#!/usr/bin/env bash
# Introspection CLEANUP: restore the NG Lightbox baseline (no patterns, Colorbox renderer as
# installed by colorbox_load_install()). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ng_lightbox.settings")
    ->set("patterns", "")
    ->set("renderer", "drupal_colorbox")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ng_lightbox.settings patterns cleared, renderer=drupal_colorbox"
