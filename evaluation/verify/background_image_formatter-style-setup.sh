#!/usr/bin/env bash
# Introspection SETUP: create content type bif_stylect with image field field_bif_style, and set
# its default view display to the Background Image formatter using image style 'thumbnail' and
# inline output, so an agent can read back the image style and output type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("bif_stylect")) { NodeType::create(["type"=>"bif_stylect","name"=>"BIF Style CT"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_bif_style")) {
    FieldStorageConfig::create(["field_name"=>"field_bif_style","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node","bif_stylect","field_bif_style")) {
    FieldConfig::create(["field_name"=>"field_bif_style","entity_type"=>"node","bundle"=>"bif_stylect","label"=>"Bg"])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","bif_stylect","default");
  $vd->setComponent("field_bif_style", [
    "type"=>"background_image_formatter","label"=>"hidden","weight"=>0,"region"=>"content",
    "settings"=>["image_style"=>"thumbnail","background_image_output_type"=>"inline","background_image_selector"=>".bif-bg","background_image_link"=>FALSE,"background_image_link_custom"=>""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.bif_stylect field_bif_style uses background_image_formatter (inline, image_style=thumbnail)"
