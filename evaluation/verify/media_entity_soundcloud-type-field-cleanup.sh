#!/usr/bin/env bash
# Introspection CLEANUP: delete mes_intro media type and its source field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($t = MediaType::load("mes_intro")) { $t->delete(); }
  if ($fc = FieldConfig::loadByName("media", "mes_intro", "field_mes_iurl")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_mes_iurl")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mes_intro + field_mes_iurl removed"
