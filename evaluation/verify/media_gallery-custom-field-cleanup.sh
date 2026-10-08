#!/usr/bin/env bash
# Introspection CLEANUP: remove field_mg_note from the media_gallery entity. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("media_gallery", "media_gallery", "field_mg_note")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media_gallery", "field_mg_note")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_mg_note removed"
