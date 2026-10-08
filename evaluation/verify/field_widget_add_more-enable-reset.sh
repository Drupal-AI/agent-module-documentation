#!/usr/bin/env bash
# Execution RESET: ensure a cardinality-3 string field field_fwam_task exists on Article with
# field_widget_add_more "Show add more button" OFF (so verify FAILS until the agent enables it).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fwam_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_fwam_task", "entity_type" => "node",
      "type" => "string", "cardinality" => 3,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fwam_task")) {
    FieldConfig::create([
      "field_name" => "field_fwam_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Task Capped Field",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_fwam_task", [
    "type" => "string_textfield", "weight" => 60, "region" => "content",
    "third_party_settings" => ["field_widget_add_more" => ["add_more" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_fwam_task present with field_widget_add_more.add_more=FALSE"
