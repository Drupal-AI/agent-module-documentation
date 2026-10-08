#!/usr/bin/env bash
# Execution RESET: ensure FILE field field_insert_task exists on Article with a file_generic widget
# on the default form display and Insert DISABLED (styles empty), so verify FAILS until the agent
# enables an insert style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_insert_task")) {
    FieldStorageConfig::create(["field_name" => "field_insert_task", "entity_type" => "node", "type" => "file"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_insert_task")) {
    FieldConfig::create(["field_name" => "field_insert_task", "entity_type" => "node", "bundle" => "article", "label" => "Task Attachment"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_insert_task", [
    "type" => "file_generic", "weight" => 60, "region" => "content",
    "third_party_settings" => ["insert" => ["styles" => [], "default" => "insert__auto"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_insert_task file_generic, Insert disabled (styles empty)"
