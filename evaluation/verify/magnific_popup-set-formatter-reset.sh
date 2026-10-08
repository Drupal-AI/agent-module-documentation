#!/usr/bin/env bash
# Execution RESET: ensure image field field_mfp_task exists on Article and its default display
# uses the DEFAULT core 'image' formatter (NOT magnific_popup), so verify FAILS until the agent
# switches the formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_mfp_task")) {
    FieldStorageConfig::create(["field_name"=>"field_mfp_task","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_mfp_task")) {
    FieldConfig::create(["field_name"=>"field_mfp_task","entity_type"=>"node","bundle"=>"article","label"=>"MFP Task"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_mfp_task", ["type"=>"image","region"=>"content","label"=>"hidden","settings"=>["image_style"=>"","image_link"=>""]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_mfp_task uses core image formatter"
