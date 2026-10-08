#!/usr/bin/env bash
# Introspection CLEANUP: remove the field_srt_known display component and the field. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd && $vd->getComponent("field_srt_known")) { $vd->removeComponent("field_srt_known")->save(); }
  if ($fc = FieldConfig::loadByName("node","article","field_srt_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_srt_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_srt_known removed"
