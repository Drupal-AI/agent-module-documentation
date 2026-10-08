#!/usr/bin/env bash
# Execution CLEANUP: delete media type mc_fmt_type, its view display, and Crowdriff source
# field. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.mc_fmt_type.default")) { $vd->delete(); }
  if ($fc = FieldConfig::loadByName("media","mc_fmt_type","field_media_media_crowdriff")) { $fc->delete(); }
  if ($t = MediaType::load("mc_fmt_type")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media","field_media_media_crowdriff")) {
    if (count($fs->getBundles()) === 0) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mc_fmt_type removed"
