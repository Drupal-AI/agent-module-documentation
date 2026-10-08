#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline — clear the media-type restriction so all
# media types are offered again (install default is an empty map). Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_library_bulk_upload.settings")
    ->set("media_types", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media_library_bulk_upload.settings media_types reset to empty (all types offered)"
