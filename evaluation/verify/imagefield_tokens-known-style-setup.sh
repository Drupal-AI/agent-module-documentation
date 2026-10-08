#!/usr/bin/env bash
# Introspection SETUP: create an Image field field_ift_style on Article whose imagefield_tokens
# widget is configured with preview_image_style 'medium', so an agent can read that widget setting.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ift_style")) { FieldStorageConfig::create(["field_name"=>"field_ift_style","entity_type"=>"node","type"=>"image","cardinality"=>1])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ift_style")) { FieldConfig::create(["field_name"=>"field_ift_style","entity_type"=>"node","bundle"=>"article","label"=>"IFT Style"])->save(); }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_ift_style", ["type"=>"imagefield_tokens","weight"=>50,"region"=>"content","settings"=>["preview_image_style"=>"medium","progress_indicator"=>"throbber"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ift_style imagefield_tokens widget preview_image_style=medium"
