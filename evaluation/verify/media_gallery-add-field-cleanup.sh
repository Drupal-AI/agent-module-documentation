#!/usr/bin/env bash
# Execution CLEANUP: remove field_mg_caption from the media_gallery bundle. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("media_gallery", "media_gallery", "field_mg_caption")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media_gallery", "field_mg_caption")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_mg_caption removed"
