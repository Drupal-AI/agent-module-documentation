#!/usr/bin/env bash
# Execution RESET: ensure list_string field field_ot_label exists on Article using the
# options_table widget with NO toggle_label set, so verify FAILS until the agent sets
# toggle_label to 'Selected'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ot_label")) {
    FieldStorageConfig::create([
      "field_name" => "field_ot_label", "entity_type" => "node", "type" => "list_string",
      "cardinality" => -1,
      "settings" => ["allowed_values" => ["x" => "X", "y" => "Y", "z" => "Z"]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ot_label")) {
    FieldConfig::create([
      "field_name" => "field_ot_label", "entity_type" => "node",
      "bundle" => "article", "label" => "Labelled Choices",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ot_label", ["type" => "options_table", "weight" => 54, "region" => "content", "settings" => ["toggle_label" => NULL], "third_party_settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ot_label uses options_table with toggle_label unset"
