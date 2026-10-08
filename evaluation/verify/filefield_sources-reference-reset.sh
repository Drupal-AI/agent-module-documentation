#!/usr/bin/env bash
# Execution RESET: create file field field_ffs_ref on Article with ONLY Upload enabled, so verify
# FAILS until the agent enables the Reference existing source. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ffs_ref")) {
    FieldStorageConfig::create(["field_name" => "field_ffs_ref", "entity_type" => "node", "type" => "file"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ffs_ref")) {
    FieldConfig::create(["field_name" => "field_ffs_ref", "entity_type" => "node", "bundle" => "article", "label" => "FFS Ref"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ffs_ref", [
    "type" => "file_generic", "weight" => 50, "region" => "content",
    "third_party_settings" => ["filefield_sources" => ["filefield_sources" => ["sources" => ["upload"=>"upload"]]]],
  ])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ffs_ref sources=upload only"
