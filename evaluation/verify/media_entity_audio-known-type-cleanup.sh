#!/usr/bin/env bash
# Introspection CLEANUP: remove the mea_known media type and its source field. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($t = MediaType::load("mea_known")) {
    $sf = $t->get("source_configuration")["source_field"] ?? NULL;
    $t->delete();
    if ($sf && ($fsc = FieldStorageConfig::loadByName("media", $sf))) { $fsc->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media type mea_known removed"
