#!/usr/bin/env bash
# Execution CLEANUP: delete mes_embed media type, its source field, and view display. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.mes_embed.default");
  if ($vd) { $vd->delete(); }
  if ($t = MediaType::load("mes_embed")) { $t->delete(); }
  if ($fc = FieldConfig::loadByName("media", "mes_embed", "field_mes_eurl")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_mes_eurl")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mes_embed + field_mes_eurl removed"
