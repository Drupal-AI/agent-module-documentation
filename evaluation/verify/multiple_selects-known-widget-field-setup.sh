#!/usr/bin/env bash
# Introspection SETUP: create a namespaced content type msel_ct with one multi-value
# list_string field, field_msel_known, whose default form display uses the
# multiple_selects module's widget (multiple_options_select). The agent must inspect the
# live form display to find which field uses that widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;

  if (!NodeType::load("msel_ct")) {
    NodeType::create(["type" => "msel_ct", "name" => "Multiple Selects Eval CT"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_msel_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_msel_known", "entity_type" => "node",
      "type" => "list_string", "cardinality" => -1,
      "settings" => ["allowed_values" => ["a" => "Alpha", "b" => "Beta", "c" => "Gamma"]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "msel_ct", "field_msel_known")) {
    FieldConfig::create([
      "field_name" => "field_msel_known", "entity_type" => "node",
      "bundle" => "msel_ct", "label" => "Known Options",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.msel_ct.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
      "targetEntityType" => "node", "bundle" => "msel_ct", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_msel_known", [
    "type" => "multiple_options_select", "weight" => 10, "region" => "content",
    "settings" => ["element_type" => "select"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.msel_ct field_msel_known uses multiple_options_select widget"
