#!/usr/bin/env bash
# Introspection SETUP: create an Image field field_plw_img on Article using plupload_image_widget with
# preview_image_style 'large', so an agent can read the configured preview style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_plw_img")) { FieldStorageConfig::create(["field_name"=>"field_plw_img","entity_type"=>"node","type"=>"image","cardinality"=>1])->save(); }
  if (!FieldConfig::loadByName("node","article","field_plw_img")) { FieldConfig::create(["field_name"=>"field_plw_img","entity_type"=>"node","bundle"=>"article","label"=>"PLW Img"])->save(); }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_plw_img", ["type"=>"plupload_image_widget","weight"=>50,"region"=>"content","settings"=>["preview_image_style"=>"large"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_plw_img plupload_image_widget preview_image_style=large"
