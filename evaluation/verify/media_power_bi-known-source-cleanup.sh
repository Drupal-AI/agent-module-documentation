#!/usr/bin/env bash
# Introspection CLEANUP: delete media type mpb_powerbi and its namespaced source field.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("media", "mpb_powerbi", "field_mpb_pbi")) { $fc->delete(); }
  if ($mt = MediaType::load("mpb_powerbi")) { $mt->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_mpb_pbi")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: media type mpb_powerbi and field_mpb_pbi removed"
