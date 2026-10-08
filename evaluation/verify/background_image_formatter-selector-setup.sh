#!/usr/bin/env bash
# Introspection SETUP: create content type bif_selct with image field field_bif_hero, and set
# its default view display to the Background Image formatter (css output, selector .bif-eval-hero)
# so an inspecting agent can read back the selector and output type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("bif_selct")) { NodeType::create(["type"=>"bif_selct","name"=>"BIF Selector CT"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_bif_hero")) {
    FieldStorageConfig::create(["field_name"=>"field_bif_hero","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node","bif_selct","field_bif_hero")) {
    FieldConfig::create(["field_name"=>"field_bif_hero","entity_type"=>"node","bundle"=>"bif_selct","label"=>"Hero"])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","bif_selct","default");
  $vd->setComponent("field_bif_hero", [
    "type"=>"background_image_formatter","label"=>"hidden","weight"=>0,"region"=>"content",
    "settings"=>["image_style"=>"","background_image_output_type"=>"css","background_image_selector"=>".bif-eval-hero","background_image_link"=>FALSE,"background_image_link_custom"=>""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.bif_selct field_bif_hero uses background_image_formatter (css, .bif-eval-hero)"
