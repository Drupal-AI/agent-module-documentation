#!/usr/bin/env bash
# Introspection SETUP: create an image field field_ts_known on Article and set its default view
# display formatter to Tiny Slider (tiny_slider_field_formatter) with items=5, so an inspecting
# agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ts_known")) {
    FieldStorageConfig::create(["field_name" => "field_ts_known", "entity_type" => "node", "type" => "image", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ts_known")) {
    FieldConfig::create(["field_name" => "field_ts_known", "entity_type" => "node", "bundle" => "article", "label" => "Known Gallery"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ts_known", [
    "type" => "tiny_slider_field_formatter", "label" => "hidden", "region" => "content",
    "settings" => ["items" => 5, "autoplay" => TRUE, "nav" => TRUE, "controls" => TRUE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ts_known uses tiny_slider_field_formatter with items=5"
