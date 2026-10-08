#!/usr/bin/env bash
# Introspection SETUP: create msel_ct with TWO multi-value list_string fields —
# field_msel_multi using the multiple_selects widget (multiple_options_select), and
# field_msel_single using core's default options widget (options_select) — so the agent
# must inspect the live form display to tell which one uses the module's widget.
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
  foreach (["field_msel_multi", "field_msel_single"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node",
        "type" => "list_string", "cardinality" => -1,
        "settings" => ["allowed_values" => ["a" => "Alpha", "b" => "Beta", "c" => "Gamma"]],
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "msel_ct", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node", "bundle" => "msel_ct",
        "label" => ($fn === "field_msel_multi" ? "Multi Widget" : "Single Widget"),
      ])->save();
    }
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.msel_ct.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
      "targetEntityType" => "node", "bundle" => "msel_ct", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_msel_multi", [
    "type" => "multiple_options_select", "weight" => 10, "region" => "content",
    "settings" => ["element_type" => "select"],
  ]);
  $fd->setComponent("field_msel_single", [
    "type" => "options_select", "weight" => 11, "region" => "content", "settings" => [],
  ]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_msel_multi=multiple_options_select, field_msel_single=options_select"
