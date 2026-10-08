#!/usr/bin/env bash
# Execution RESET: ensure image field field_ag_pic exists on Article with the plain 'image'
# formatter on the default view display, so verify FAILS until the agent switches it to
# animated_gif_image_url.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ag_pic")) {
    FieldStorageConfig::create(["field_name"=>"field_ag_pic","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ag_pic")) {
    FieldConfig::create(["field_name"=>"field_ag_pic","entity_type"=>"node","bundle"=>"article","label"=>"AG Pic"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ag_pic", ["type"=>"image","label"=>"hidden","weight"=>50,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ag_pic present with plain image formatter"
