#!/usr/bin/env bash
# Introspection CLEANUP: delete the mc_probe_asset media entity, the mc_asset_type media type,
# and its Crowdriff source field. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name"=>"mc_probe_asset"]) as $m) { $m->delete(); }
  if ($fc = FieldConfig::loadByName("media","mc_asset_type","field_media_media_crowdriff")) { $fc->delete(); }
  if ($t = MediaType::load("mc_asset_type")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media","field_media_media_crowdriff")) {
    if (count($fs->getBundles()) === 0) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mc_probe_asset + mc_asset_type removed"
