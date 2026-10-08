#!/usr/bin/env bash
# Introspection SETUP: create a Material Icons field field_mi_known on Article and configure its
# widget on the default form display with default_style = 'outlined', so an inspecting agent can
# read the configured default style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_mi_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_mi_known", "entity_type" => "node", "type" => "material_icons",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_mi_known")) {
    FieldConfig::create([
      "field_name" => "field_mi_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Icon",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_mi_known", [
    "type" => "material_icons", "weight" => 55, "region" => "content",
    "settings" => ["allow_style" => TRUE, "default_style" => "outlined", "allow_classes" => TRUE],
  ])->save();
' >/dev/null 2>&1
echo "setup: node.article field_mi_known widget default_style=outlined"
