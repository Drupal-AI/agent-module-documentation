#!/usr/bin/env bash
# Execution RESET: ensure a plugin:condition field field_plugin_wtask exists on Article, then
# REMOVE its default-form-display component (field hidden / no Plugin selector widget) so verify
# FAILS until the agent assigns the Plugin selector widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_plugin_wtask")) {
    FieldStorageConfig::create([
      "field_name" => "field_plugin_wtask", "entity_type" => "node", "type" => "plugin:condition",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_plugin_wtask")) {
    FieldConfig::create([
      "field_name" => "field_plugin_wtask", "entity_type" => "node",
      "bundle" => "article", "label" => "Widget Task Plugin Ref",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->removeComponent("field_plugin_wtask")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_plugin_wtask present, form-display component removed (no widget)"
