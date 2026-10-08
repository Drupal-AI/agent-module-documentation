#!/usr/bin/env bash
# Execution RESET: enable submodule; ensure list_string field field_imsw_task on Article uses core
# options_select so verify FAILS until agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en ims_options_widget -y >/dev/null 2>&1
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_imsw_task")) {
    FieldStorageConfig::create(["field_name" => "field_imsw_task", "entity_type" => "node", "type" => "list_string", "cardinality" => -1, "settings" => ["allowed_values" => ["a" => "A", "b" => "B", "c" => "C"]]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_imsw_task")) {
    FieldConfig::create(["field_name" => "field_imsw_task", "entity_type" => "node", "bundle" => "article", "label" => "Task Tags"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_imsw_task", ["type" => "options_select", "weight" => 73, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_imsw_task uses options_select"
