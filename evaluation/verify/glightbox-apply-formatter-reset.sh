#!/usr/bin/env bash
# Execution RESET: ensure image field field_glb_img exists on Article shown with the plain 'image'
# formatter, so verify FAILS until the agent switches it to the glightbox formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_glb_img")) {
    FieldStorageConfig::create(["field_name"=>"field_glb_img","entity_type"=>"node","type"=>"image","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_glb_img")) {
    FieldConfig::create(["field_name"=>"field_glb_img","entity_type"=>"node","bundle"=>"article","label"=>"GLB Gallery"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_glb_img", ["type"=>"image","label"=>"hidden","weight"=>60,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_glb_img shown with the plain 'image' formatter"
