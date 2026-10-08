#!/usr/bin/env bash
# Execution RESET: ensure image field field_ic_task on Article uses the Image formatter on the
# DEFAULT view mode with NO image_class class (so verify FAILS until the agent adds one). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ic_task")) {
    FieldStorageConfig::create(["field_name"=>"field_ic_task","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ic_task")) {
    FieldConfig::create(["field_name"=>"field_ic_task","entity_type"=>"node","bundle"=>"article","label"=>"IC Task Image"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ic_task", ["type"=>"image","label"=>"hidden","weight"=>50,"region"=>"content","settings"=>["image_style"=>"","image_link"=>""],"third_party_settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ic_task (image, default) has NO image_class class"
