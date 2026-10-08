#!/usr/bin/env bash
# Execution RESET: ensure content type mrt_ct exists with a Media entity-reference field
# field_mrt_media, and the mrt_style responsive image style exists, but force the default
# view display's field_mrt_media component to a DIFFERENT formatter
# (entity_reference_entity_id) so verify FAILS until the agent switches it to
# media_responsive_thumbnail with responsive_image_style=mrt_style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\responsive_image\Entity\ResponsiveImageStyle;

  if (!NodeType::load("mrt_ct")) {
    NodeType::create(["type" => "mrt_ct", "name" => "MRT Test Content"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_mrt_media")) {
    FieldStorageConfig::create([
      "field_name" => "field_mrt_media", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "media"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "mrt_ct", "field_mrt_media")) {
    FieldConfig::create([
      "field_name" => "field_mrt_media", "entity_type" => "node",
      "bundle" => "mrt_ct", "label" => "MRT Media",
      "settings" => ["handler_settings" => ["target_bundles" => ["image" => "image"]]],
    ])->save();
  }
  if (!ResponsiveImageStyle::load("mrt_style")) {
    ResponsiveImageStyle::create([
      "id" => "mrt_style", "label" => "MRT Style",
      "breakpoint_group" => "responsive_image",
      "fallback_image_style" => "thumbnail",
      "image_style_mappings" => [[
        "image_mapping_type" => "image_style",
        "image_mapping" => "thumbnail",
        "breakpoint_id" => "responsive_image.viewport_sizing",
        "multiplier" => "1x",
      ]],
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.mrt_ct.default");
  if (!$vd) {
    $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->create([
      "targetEntityType" => "node", "bundle" => "mrt_ct", "mode" => "default", "status" => TRUE,
    ]);
  }
  $vd->setComponent("field_mrt_media", [
    "type" => "entity_reference_entity_id", "weight" => 10, "label" => "hidden", "region" => "content",
    "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.mrt_ct field_mrt_media uses entity_reference_entity_id (not media_responsive_thumbnail)"
