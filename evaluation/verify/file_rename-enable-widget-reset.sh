#!/usr/bin/env bash
# Execution RESET: ensure file field field_fr_task exists on Article with a file_generic widget
# on the default form display, and force file_rename "Show rename link" OFF (show_rename_link
# FALSE) so verify FAILS until the agent enables it. Also force the global flag OFF so only the
# per-widget setting can satisfy verify. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set file_rename.settings always_show_widget_link 0 -y >/dev/null 2>&1
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fr_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_fr_task", "entity_type" => "node",
      "type" => "file", "cardinality" => 1,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fr_task")) {
    FieldConfig::create([
      "field_name" => "field_fr_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Task File",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_fr_task", [
    "type" => "file_generic", "weight" => 60, "region" => "content",
    "third_party_settings" => ["file_rename" => ["show_rename_link" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_fr_task present with file_rename.show_rename_link=FALSE"
