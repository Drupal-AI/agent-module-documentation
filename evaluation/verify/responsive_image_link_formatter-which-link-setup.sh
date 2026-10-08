#!/usr/bin/env bash
# Introspection SETUP: Article gets an image + link field; the image field's default view display
# uses responsive_image_link_formatter (responsive style 'wide') wrapping the link field.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_rilf_img")) {
    FieldStorageConfig::create(["field_name" => "field_rilf_img", "entity_type" => "node", "type" => "image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_rilf_img")) {
    FieldConfig::create(["field_name" => "field_rilf_img", "entity_type" => "node", "bundle" => "article", "label" => "RILF Image"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_rilf_link")) {
    FieldStorageConfig::create(["field_name" => "field_rilf_link", "entity_type" => "node", "type" => "link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_rilf_link")) {
    FieldConfig::create(["field_name" => "field_rilf_link", "entity_type" => "node", "bundle" => "article", "label" => "RILF Link"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_rilf_img", ["type" => "responsive_image_link_formatter", "label" => "hidden", "weight" => 91, "region" => "content", "settings" => ["responsive_image_style" => "wide", "image_link" => "field_rilf_link"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_rilf_img uses responsive_image_link_formatter wrapping field_rilf_link"
