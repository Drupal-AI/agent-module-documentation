#!/usr/bin/env bash
# Execution RESET for "restore the module's shipped resize image styles".
# Deletes the four cke_media_resize_* image styles (and, by config dependency, the media
# view displays that reference them) so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("image_style");
  foreach (["cke_media_resize_small","cke_media_resize_medium","cke_media_resize_large","cke_media_resize_xl"] as $id) {
    if ($style = $storage->load($id)) { $style->delete(); }
  }
' >/dev/null 2>&1

echo "reset: cke_media_resize_{small,medium,large,xl} image styles deleted"
