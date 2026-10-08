#!/usr/bin/env bash
# Execution RESET: field_ilf_img already uses image_link_formatter but image_link is empty (images
# not clickable). Verify FAILS until the agent points it at the link field.
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
  $vd->setComponent("field_ilf_img", ["type" => "image_link_formatter", "label" => "hidden", "weight" => 90, "region" => "content", "settings" => ["image_style" => "", "image_link" => ""]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ilf_img uses image_link_formatter but image_link is empty"
