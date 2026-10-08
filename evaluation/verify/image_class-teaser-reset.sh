#!/usr/bin/env bash
# Execution RESET: image field field_ic_teaser on Article, shown with the Image formatter on BOTH
# the default and TEASER view modes, no image_class class anywhere. verify checks the TEASER mode.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ic_teaser")) {
    FieldStorageConfig::create(["field_name"=>"field_ic_teaser","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ic_teaser")) {
    FieldConfig::create(["field_name"=>"field_ic_teaser","entity_type"=>"node","bundle"=>"article","label"=>"IC Teaser Image"])->save();
  }
  $etm = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  foreach (["node.article.default","node.article.teaser"] as $id) {
    $vd = $etm->load($id);
    if ($vd) {
      $vd->setComponent("field_ic_teaser", ["type"=>"image","label"=>"hidden","weight"=>50,"region"=>"content","settings"=>["image_style"=>"","image_link"=>""],"third_party_settings"=>[]])->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ic_teaser on default+teaser, no class"
