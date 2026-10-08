#!/usr/bin/env bash
# Introspection SETUP: give Article an image field + link field and set the image field's default
# view display to the image_link_formatter, wrapping with the link field.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ilf_img")) {
    FieldStorageConfig::create(["field_name" => "field_ilf_img", "entity_type" => "node", "type" => "image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ilf_img")) {
    FieldConfig::create(["field_name" => "field_ilf_img", "entity_type" => "node", "bundle" => "article", "label" => "ILF Image"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_ilf_link")) {
    FieldStorageConfig::create(["field_name" => "field_ilf_link", "entity_type" => "node", "type" => "link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ilf_link")) {
    FieldConfig::create(["field_name" => "field_ilf_link", "entity_type" => "node", "bundle" => "article", "label" => "ILF Link"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ilf_img", ["type" => "image_link_formatter", "label" => "hidden", "weight" => 90, "region" => "content", "settings" => ["image_style" => "", "image_link" => "field_ilf_link"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ilf_img uses image_link_formatter wrapping field_ilf_link"
