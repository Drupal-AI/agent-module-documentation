#!/usr/bin/env bash
# Execution RESET: remove the lm_gallery media type (plus its media items and fields) so
# verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["bundle" => "lm_gallery"]) as $m) { $m->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("field_config")->loadByProperties(["entity_type" => "media", "bundle" => "lm_gallery"]) as $fc) { $fc->delete(); }
  foreach (["entity_form_display", "entity_view_display"] as $type) {
    foreach (\Drupal::entityTypeManager()->getStorage($type)->loadByProperties(["targetEntityType" => "media", "bundle" => "lm_gallery"]) as $d) { $d->delete(); }
  }
  if ($t = MediaType::load("lm_gallery")) { $t->delete(); }
  foreach (["field_media_image_1", "field_media_lm_gallery"] as $name) {
    if ($fs = FieldStorageConfig::loadByName("media", $name)) { if (!$fs->getBundles()) { $fs->delete(); } }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media type lm_gallery removed"
