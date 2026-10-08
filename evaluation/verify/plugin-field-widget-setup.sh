#!/usr/bin/env bash
# Introspection SETUP: create a plugin:action field on Article and set its edit widget to the
# Plugin module's derived Plugin selector widget (plugin_selector:plugin_select_list) on the
# default form display, so the agent can read back which widget the field uses. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_plugin_widget")) {
    FieldStorageConfig::create([
      "field_name" => "field_plugin_widget", "entity_type" => "node", "type" => "plugin:action",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_plugin_widget")) {
    FieldConfig::create([
      "field_name" => "field_plugin_widget", "entity_type" => "node",
      "bundle" => "article", "label" => "Widget Plugin Ref",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_plugin_widget", [
    "type" => "plugin_selector:plugin_select_list", "weight" => 60, "region" => "content",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_plugin_widget (plugin:action) uses widget plugin_selector:plugin_select_list"
