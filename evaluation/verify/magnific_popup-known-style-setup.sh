#!/usr/bin/env bash
# Introspection SETUP: create image field field_mfp_sty on Article with magnific_popup formatter
# using thumbnail_image_style=thumbnail, popup_image_style=large. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_mfp_sty")) {
    FieldStorageConfig::create(["field_name"=>"field_mfp_sty","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_mfp_sty")) {
    FieldConfig::create(["field_name"=>"field_mfp_sty","entity_type"=>"node","bundle"=>"article","label"=>"MFP Styled"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_mfp_sty", ["type"=>"magnific_popup","region"=>"content","label"=>"hidden",
    "settings"=>["thumbnail_image_style"=>"thumbnail","popup_image_style"=>"large","gallery_type"=>"all_items","vertical_fit"=>"true"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_mfp_sty magnific_popup popup_image_style=large"
