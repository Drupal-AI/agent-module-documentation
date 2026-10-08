#!/usr/bin/env bash
# Introspection SETUP: create a JSON field field_jfw_schema on Article whose json_editor
# widget carries a concrete JSON Schema (required property "jfwWidgetProbe") with
# schema_validate enabled, so the agent must read the live widget settings to answer.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_jfw_schema")) {
    FieldStorageConfig::create([
      "field_name" => "field_jfw_schema", "entity_type" => "node", "type" => "json",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_jfw_schema")) {
    FieldConfig::create([
      "field_name" => "field_jfw_schema", "entity_type" => "node",
      "bundle" => "article", "label" => "Schema Payload",
    ])->save();
  }
  $schema = json_encode([
    "type" => "object",
    "required" => ["jfwWidgetProbe"],
    "properties" => ["jfwWidgetProbe" => ["type" => "string"]],
  ]);
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_jfw_schema", [
    "type" => "json_editor", "weight" => 65, "region" => "content",
    "settings" => [
      "mode" => "code",
      "modes" => ["code" => "code", "text" => "text"],
      "schema" => $schema,
      "schema_validate" => TRUE,
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_jfw_schema json_editor schema requires jfwWidgetProbe, schema_validate=TRUE"
