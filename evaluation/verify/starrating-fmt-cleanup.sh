#!/usr/bin/env bash
# Execution CLEANUP: remove field_srt_fmt display component + field from Article. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd && $vd->getComponent("field_srt_fmt")) { $vd->removeComponent("field_srt_fmt")->save(); }
  if ($fc = FieldConfig::loadByName("node","article","field_srt_fmt")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_srt_fmt")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_srt_fmt removed"
