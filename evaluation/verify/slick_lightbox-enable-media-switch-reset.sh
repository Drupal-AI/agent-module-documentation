#!/usr/bin/env bash
# Execution RESET: ensure a namespaced image field field_sl_image exists on Article and its
# default view-display component uses a plain 'image' formatter (NO media_switch), so verify
# FAILS until the agent switches it to a Blazy formatter with media_switch=slick_lightbox.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_sl_image")) {
    FieldStorageConfig::create([
      "field_name" => "field_sl_image", "entity_type" => "node", "type" => "image",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_sl_image")) {
    FieldConfig::create([
      "field_name" => "field_sl_image", "entity_type" => "node",
      "bundle" => "article", "label" => "SL Image",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_sl_image", [
    "type" => "image", "weight" => 60, "region" => "content", "label" => "hidden",
    "settings" => [],
  ])->save();
' >/dev/null 2>&1
echo "reset: node.article field_sl_image present with plain image formatter (no media_switch)"
