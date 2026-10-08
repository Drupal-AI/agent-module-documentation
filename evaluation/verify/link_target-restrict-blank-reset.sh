#!/usr/bin/env bash
# Execution RESET: ensure the namespaced fixture content type ltgt_ct exists with a link field
# field_ltgt_promo whose default-form-display widget is already link_target's
# link_target_field_widget, but with available_targets EMPTY (all four targets available), so
# verify FAILS until the agent restricts it to only _blank. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;

  if (!NodeType::load("ltgt_ct")) {
    NodeType::create(["type" => "ltgt_ct", "name" => "Link Target Eval CT"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_ltgt_promo")) {
    FieldStorageConfig::create([
      "field_name" => "field_ltgt_promo", "entity_type" => "node", "type" => "link",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "ltgt_ct", "field_ltgt_promo")) {
    FieldConfig::create([
      "field_name" => "field_ltgt_promo", "entity_type" => "node",
      "bundle" => "ltgt_ct", "label" => "Promo Link",
    ])->save();
  }

  $storage = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $storage->load("node.ltgt_ct.default");
  if (!$fd) {
    $fd = $storage->create([
      "targetEntityType" => "node", "bundle" => "ltgt_ct", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_ltgt_promo", [
    "type" => "link_target_field_widget", "weight" => 10, "region" => "content",
    "settings" => ["placeholder_url" => "", "placeholder_title" => "", "available_targets" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.ltgt_ct field_ltgt_promo present, link_target_field_widget, available_targets=[] (all allowed)"
