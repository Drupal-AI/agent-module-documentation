#!/usr/bin/env bash
# Execution RESET: ensure list_integer field field_ot_task exists on Article with the core
# options_select widget (NOT options_table), so verify FAILS until the agent switches the
# widget to options_table. Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ot_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_ot_task", "entity_type" => "node", "type" => "list_integer",
      "cardinality" => -1,
      "settings" => ["allowed_values" => [1 => "One", 2 => "Two", 3 => "Three"]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ot_task")) {
    FieldConfig::create([
      "field_name" => "field_ot_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Task Levels",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ot_task", ["type" => "options_select", "weight" => 53, "region" => "content", "settings" => [], "third_party_settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ot_task present with widget options_select"
