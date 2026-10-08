#!/usr/bin/env bash
# Introspection SETUP: create an entity_reference field on Article whose default form-display
# widget is the Entity Browser - Table widget, so an agent can read back which field uses it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ebt_refs")) {
    FieldStorageConfig::create([
      "field_name" => "field_ebt_refs", "entity_type" => "node", "type" => "entity_reference",
      "cardinality" => -1, "settings" => ["target_type" => "node"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ebt_refs")) {
    FieldConfig::create([
      "field_name" => "field_ebt_refs", "entity_type" => "node", "bundle" => "article",
      "label" => "EBT Related", "settings" => ["handler" => "default:node"],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ebt_refs", [
    "type" => "entity_reference_browser_table_widget", "weight" => 60, "region" => "content",
    "settings" => [
      "entity_browser" => "", "field_widget_display" => "label",
      "field_widget_display_settings" => [], "field_widget_edit" => TRUE,
      "field_widget_remove" => TRUE, "field_widget_replace" => FALSE,
      "selection_mode" => "selection_append", "open" => FALSE,
      "additional_fields" => ["options" => ["status" => "status"]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ebt_refs uses entity_reference_browser_table_widget"
