#!/usr/bin/env bash
# Execution CLEANUP: remove the mea_show media type, display and source field. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.mea_show.default")) { $vd->delete(); }
  if ($t = MediaType::load("mea_show")) {
    $sf = $t->get("source_configuration")["source_field"] ?? NULL;
    $t->delete();
    if ($sf && ($fsc = FieldStorageConfig::loadByName("media", $sf))) { $fsc->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media type mea_show removed"
