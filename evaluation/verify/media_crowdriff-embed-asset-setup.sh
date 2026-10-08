#!/usr/bin/env bash
# Introspection SETUP: create media type mc_asset_type (Crowdriff source) and one Crowdriff
# media asset "mc_probe_asset" whose embed code contains the id cr-init__abcd1234, so the
# agent must inspect the live media entity to report the embedded Crowdriff id. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\media\Entity\Media;
  if (!MediaType::load("mc_asset_type")) {
    $t = MediaType::create(["id"=>"mc_asset_type","label"=>"MC Asset Type","source"=>"media_crowdriff"]);
    $t->save();
    $f = $t->getSource()->createSourceField($t);
    $f->getFieldStorageDefinition()->save();
    $f->save();
    $t->set("source_configuration",["source_field"=>$f->getName()])->save();
  }
  $existing = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name"=>"mc_probe_asset"]);
  if (!$existing) {
    Media::create([
      "bundle"=>"mc_asset_type","name"=>"mc_probe_asset",
      "field_media_media_crowdriff"=>"<div id=\"cr-init__abcd1234\"></div>",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media mc_probe_asset (bundle mc_asset_type) embeds Crowdriff id cr-init__abcd1234"
