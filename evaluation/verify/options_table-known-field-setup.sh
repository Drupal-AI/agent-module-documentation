#!/usr/bin/env bash
# Introspection SETUP: create a list_string field field_ot_known on Article using the
# options_table (Draggable Table) widget with toggle_label 'Choose', so an inspecting agent
# can read back which field uses the draggable table widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ot_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_ot_known", "entity_type" => "node", "type" => "list_string",
      "cardinality" => -1,
      "settings" => ["allowed_values" => ["red" => "Red", "green" => "Green", "blue" => "Blue"]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ot_known")) {
    FieldConfig::create([
      "field_name" => "field_ot_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Choices",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ot_known", [
    "type" => "options_table", "weight" => 50, "region" => "content",
    "settings" => ["toggle_label" => "Choose"], "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ot_known uses widget options_table (toggle_label=Choose)"
