#!/usr/bin/env bash
# Introspection SETUP: create the namespaced fixture content type ltgt_ct with a link field
# field_ltgt_url, set its default-form-display widget to link_target's link_target_field_widget,
# and restrict the available_targets widget setting to only _blank, so an inspecting agent can
# read back which target(s) are enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;

  if (!NodeType::load("ltgt_ct")) {
    NodeType::create(["type" => "ltgt_ct", "name" => "Link Target Eval CT"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_ltgt_url")) {
    FieldStorageConfig::create([
      "field_name" => "field_ltgt_url", "entity_type" => "node", "type" => "link",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "ltgt_ct", "field_ltgt_url")) {
    FieldConfig::create([
      "field_name" => "field_ltgt_url", "entity_type" => "node",
      "bundle" => "ltgt_ct", "label" => "URL",
    ])->save();
  }

  $storage = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $storage->load("node.ltgt_ct.default");
  if (!$fd) {
    $fd = $storage->create([
      "targetEntityType" => "node", "bundle" => "ltgt_ct", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_ltgt_url", [
    "type" => "link_target_field_widget", "weight" => 10, "region" => "content",
    "settings" => [
      "placeholder_url" => "", "placeholder_title" => "",
      "available_targets" => ["_blank" => "_blank"],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.ltgt_ct field_ltgt_url (link_target_field_widget) restricted to available_targets=_blank"
