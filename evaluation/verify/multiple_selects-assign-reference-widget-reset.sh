#!/usr/bin/env bash
# Execution RESET: ensure msel_ct exists with a multi-value entity_reference field
# (field_msel_task, targeting users, unlimited cardinality) on its default form display,
# currently using core's plain "options_select" widget (NOT the multiple_selects widget),
# so verify FAILS until the agent switches it. Creates the type/field if missing.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;

  if (!NodeType::load("msel_ct")) {
    NodeType::create(["type" => "msel_ct", "name" => "Multiple Selects Eval CT"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_msel_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_msel_task", "entity_type" => "node",
      "type" => "entity_reference", "cardinality" => -1,
      "settings" => ["target_type" => "user"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "msel_ct", "field_msel_task")) {
    FieldConfig::create([
      "field_name" => "field_msel_task", "entity_type" => "node",
      "bundle" => "msel_ct", "label" => "Assigned Users",
      "settings" => ["handler" => "default:user"],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.msel_ct.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
      "targetEntityType" => "node", "bundle" => "msel_ct", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_msel_task", [
    "type" => "options_select", "weight" => 20, "region" => "content", "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.msel_ct field_msel_task present with options_select widget (not multiple_selects)"
