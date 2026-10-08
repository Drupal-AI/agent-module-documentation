#!/usr/bin/env bash
# Execution RESET: ensure msel_ct exists with a fixed-cardinality (4) list_string field
# (field_msel_conf) on its default form display, currently using core's plain
# "options_select" widget (NOT the multiple_selects widget), so verify FAILS until the
# agent switches it. Creates the type/field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;

  if (!NodeType::load("msel_ct")) {
    NodeType::create(["type" => "msel_ct", "name" => "Multiple Selects Eval CT"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_msel_conf")) {
    FieldStorageConfig::create([
      "field_name" => "field_msel_conf", "entity_type" => "node",
      "type" => "list_string", "cardinality" => 4,
      "settings" => ["allowed_values" => [
        "low" => "Low", "medium" => "Medium", "high" => "High", "critical" => "Critical",
      ]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "msel_ct", "field_msel_conf")) {
    FieldConfig::create([
      "field_name" => "field_msel_conf", "entity_type" => "node",
      "bundle" => "msel_ct", "label" => "Confidence Levels",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.msel_ct.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
      "targetEntityType" => "node", "bundle" => "msel_ct", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_msel_conf", [
    "type" => "options_select", "weight" => 30, "region" => "content", "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.msel_ct field_msel_conf (cardinality 4) present with options_select widget"
