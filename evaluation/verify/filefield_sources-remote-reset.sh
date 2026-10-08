#!/usr/bin/env bash
# Execution RESET: create file field field_ffs_task on Article with ONLY the default Upload source
# enabled (remote OFF), so verify FAILS until the agent enables the Remote URL source. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ffs_task")) {
    FieldStorageConfig::create(["field_name" => "field_ffs_task", "entity_type" => "node", "type" => "file"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ffs_task")) {
    FieldConfig::create(["field_name" => "field_ffs_task", "entity_type" => "node", "bundle" => "article", "label" => "FFS Task"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ffs_task", [
    "type" => "file_generic", "weight" => 50, "region" => "content",
    "third_party_settings" => ["filefield_sources" => ["filefield_sources" => ["sources" => ["upload"=>"upload"]]]],
  ])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ffs_task sources=upload only"
