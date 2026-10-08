#!/usr/bin/env bash
# Introspection SETUP: create the namespaced fixture content type ltgt_ct with two link
# fields -- field_ltgt_a using link_target's link_target_field_widget, and field_ltgt_b using
# core's plain link_default widget -- so an inspecting agent must tell which is which.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;

  if (!NodeType::load("ltgt_ct")) {
    NodeType::create(["type" => "ltgt_ct", "name" => "Link Target Eval CT"])->save();
  }
  foreach (["field_ltgt_a" => "Field A", "field_ltgt_b" => "Field B"] as $fn => $label) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node", "type" => "link",
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "ltgt_ct", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node", "bundle" => "ltgt_ct", "label" => $label,
      ])->save();
    }
  }

  $storage = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $storage->load("node.ltgt_ct.default");
  if (!$fd) {
    $fd = $storage->create([
      "targetEntityType" => "node", "bundle" => "ltgt_ct", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_ltgt_a", [
    "type" => "link_target_field_widget", "weight" => 10, "region" => "content",
    "settings" => ["placeholder_url" => "", "placeholder_title" => "", "available_targets" => []],
  ]);
  $fd->setComponent("field_ltgt_b", [
    "type" => "link_default", "weight" => 11, "region" => "content",
    "settings" => ["placeholder_url" => "", "placeholder_title" => ""],
  ]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ltgt_a=link_target_field_widget, field_ltgt_b=link_default on node.ltgt_ct"
