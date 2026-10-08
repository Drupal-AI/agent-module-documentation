#!/usr/bin/env bash
# Introspection CLEANUP: delete the lm_probe media type, its media items and its fields.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["bundle" => "lm_probe"]) as $m) { $m->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("field_config")->loadByProperties(["entity_type" => "media", "bundle" => "lm_probe"]) as $fc) { $fc->delete(); }
  if ($t = MediaType::load("lm_probe")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_media_file")) {
    if (!$fs->getBundles()) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media type lm_probe and its fields removed"
