#!/usr/bin/env bash
# Execution RESET: create/refresh the source content type etc_task_src (label "ETC Task Source")
# with a string field field_etc_task placed on its default form and view displays, and DELETE the
# target content type etc_task_dst so verify FAILS until the agent clones the type.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  // Remove the target so the clone has to be created.
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["type" => "etc_task_dst"]) as $n) { $n->delete(); }
  if ($t = NodeType::load("etc_task_dst")) { $t->delete(); }
  // Build the source.
  if (!NodeType::load("etc_task_src")) {
    NodeType::create(["type" => "etc_task_src", "name" => "ETC Task Source", "description" => "Source type for the entity_type_clone eval."])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_etc_task")) {
    FieldStorageConfig::create(["field_name" => "field_etc_task", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "etc_task_src", "field_etc_task")) {
    FieldConfig::create([
      "field_name" => "field_etc_task", "entity_type" => "node",
      "bundle" => "etc_task_src", "label" => "ETC Task Field",
    ])->save();
  }
  $repo = \Drupal::service("entity_display.repository");
  $repo->getFormDisplay("node", "etc_task_src", "default")
    ->setComponent("field_etc_task", ["type" => "string_textfield", "weight" => 10, "region" => "content"])
    ->save();
  $repo->getViewDisplay("node", "etc_task_src", "default")
    ->setComponent("field_etc_task", ["type" => "string", "label" => "above", "weight" => 10, "region" => "content"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: etc_task_src present with field_etc_task; etc_task_dst absent"
