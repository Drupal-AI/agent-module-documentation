#!/usr/bin/env bash
# Introspection CLEANUP: delete media type mpb_gov and field_mpb_gov. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("media", "mpb_gov", "field_mpb_gov")) { $fc->delete(); }
  if ($mt = MediaType::load("mpb_gov")) { $mt->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_mpb_gov")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: media type mpb_gov and field_mpb_gov removed"
