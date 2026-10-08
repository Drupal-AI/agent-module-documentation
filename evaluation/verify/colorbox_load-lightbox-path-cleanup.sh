#!/usr/bin/env bash
# Execution CLEANUP: restore the NG Lightbox baseline after the case. Idempotent. Exit 0.
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
