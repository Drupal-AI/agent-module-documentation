#!/usr/bin/env bash
# Execution RESET: ensure field_jfw_valid exists on Article with the json_editor widget but
# NO schema and schema validation OFF, so verify FAILS until the agent adds a schema that
# requires "sku" and turns schema_validate on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_jfw_valid")) {
    FieldStorageConfig::create([
      "field_name" => "field_jfw_valid", "entity_type" => "node", "type" => "json",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_jfw_valid")) {
    FieldConfig::create([
      "field_name" => "field_jfw_valid", "entity_type" => "node",
      "bundle" => "article", "label" => "Validated Payload",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_jfw_valid", [
    "type" => "json_editor", "weight" => 67, "region" => "content",
    "settings" => [
      "mode" => "code",
      "modes" => ["code" => "code", "text" => "text"],
      "schema" => "",
      "schema_validate" => FALSE,
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_jfw_valid json_editor with empty schema, schema_validate=FALSE"
