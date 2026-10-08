#!/usr/bin/env bash
# Introspection SETUP: create an image field field_glb_img on Article and set its default view-display
# formatter to 'glightbox', so an agent can read back which field opens in a GLightbox popup. Idempotent.
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
  $vd->setComponent("field_glb_img", ["type"=>"glightbox","label"=>"hidden","weight"=>60,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_glb_img uses the glightbox formatter"
