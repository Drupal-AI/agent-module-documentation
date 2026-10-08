#!/usr/bin/env bash
# Execution RESET: ensure the namespaced fixture content type ltgt_ct exists with a link field
# field_ltgt_task whose default-form-display widget is core's PLAIN link_default (not
# link_target's widget), so verify FAILS until the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;

  if (!NodeType::load("ltgt_ct")) {
    NodeType::create(["type" => "ltgt_ct", "name" => "Link Target Eval CT"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_ltgt_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_ltgt_task", "entity_type" => "node", "type" => "link",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "ltgt_ct", "field_ltgt_task")) {
    FieldConfig::create([
      "field_name" => "field_ltgt_task", "entity_type" => "node",
      "bundle" => "ltgt_ct", "label" => "Task Link",
    ])->save();
  }

  $storage = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $storage->load("node.ltgt_ct.default");
  if (!$fd) {
    $fd = $storage->create([
      "targetEntityType" => "node", "bundle" => "ltgt_ct", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_ltgt_task", [
    "type" => "link_default", "weight" => 10, "region" => "content",
    "settings" => ["placeholder_url" => "", "placeholder_title" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.ltgt_ct field_ltgt_task present with plain link_default widget"
