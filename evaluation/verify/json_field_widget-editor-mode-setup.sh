#!/usr/bin/env bash
# Introspection SETUP: create a JSON field field_jfw_known on Article and put the
# json_field_widget "json_editor" widget on it in TREE mode with a restricted mode list, so
# the agent can read the live widget settings back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_jfw_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_jfw_known", "entity_type" => "node", "type" => "json",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_jfw_known")) {
    FieldConfig::create([
      "field_name" => "field_jfw_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Editor Payload",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_jfw_known", [
    "type" => "json_editor", "weight" => 64, "region" => "content",
    "settings" => [
      "mode" => "tree",
      "modes" => ["tree" => "tree", "text" => "text"],
      "schema" => "",
      "schema_validate" => FALSE,
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_jfw_known uses json_editor with mode=tree"
