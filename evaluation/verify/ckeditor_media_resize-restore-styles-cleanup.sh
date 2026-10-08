#!/usr/bin/env bash
# Execution CLEANUP for "restore ckeditor_media_resize's shipped image styles".
# Re-installs the module's default (config/install) and optional (config/optional) config so
# the four image styles, the media view modes and the media.image.* view displays are back
# exactly as a fresh install would leave them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::service("config.installer")->installDefaultConfig("module", "ckeditor_media_resize");
  $storage = \Drupal::entityTypeManager()->getStorage("image_style");
  $have = [];
  foreach (["cke_media_resize_small","cke_media_resize_medium","cke_media_resize_large","cke_media_resize_xl"] as $id) {
    if ($storage->load($id)) { $have[] = $id; }
  }
  print implode(",", $have);
' 2>/dev/null | tail -1

echo "cleanup: ckeditor_media_resize default config re-installed"
