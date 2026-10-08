#!/usr/bin/env bash
# Introspection SETUP: put a KNOWN media-type restriction on the live site so an
# inspecting agent can read it back. Restricts Media Library Bulk Upload to only the
# Image and Document media types via config object media_library_bulk_upload.settings
# key `media_types`. Idempotent: overwrites any prior value. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_library_bulk_upload.settings")
    ->set("media_types", ["image" => "image", "document" => "document"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media_library_bulk_upload.settings media_types restricted to [image, document]"
