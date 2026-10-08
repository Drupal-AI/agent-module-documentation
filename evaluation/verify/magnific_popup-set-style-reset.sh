#!/usr/bin/env bash
# Execution RESET: ensure image field field_mfp_task2 exists on Article with magnific_popup
# formatter but popup_image_style='' and gallery_type=all_items, so verify FAILS until the agent
# sets popup_image_style=large and gallery_type=separate_items. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_mfp_task2")) {
    FieldStorageConfig::create(["field_name"=>"field_mfp_task2","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_mfp_task2")) {
    FieldConfig::create(["field_name"=>"field_mfp_task2","entity_type"=>"node","bundle"=>"article","label"=>"MFP Task2"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_mfp_task2", ["type"=>"magnific_popup","region"=>"content","label"=>"hidden",
    "settings"=>["thumbnail_image_style"=>"","popup_image_style"=>"","gallery_type"=>"all_items","vertical_fit"=>"true"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_mfp_task2 magnific_popup popup_image_style='' gallery_type=all_items"
