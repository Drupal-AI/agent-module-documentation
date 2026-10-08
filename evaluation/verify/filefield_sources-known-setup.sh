#!/usr/bin/env bash
# Introspection SETUP: create file field field_ffs_known on Article with filefield_sources enabling
# the Upload, Remote URL and Reference existing sources, so an agent can read the enabled sources
# back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ffs_known")) {
    FieldStorageConfig::create(["field_name" => "field_ffs_known", "entity_type" => "node", "type" => "file"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ffs_known")) {
    FieldConfig::create(["field_name" => "field_ffs_known", "entity_type" => "node", "bundle" => "article", "label" => "FFS Known"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ffs_known", [
    "type" => "file_generic", "weight" => 50, "region" => "content",
    "third_party_settings" => ["filefield_sources" => ["filefield_sources" => ["sources" => ["upload"=>"upload","remote"=>"remote","reference"=>"reference"]]]],
  ])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ffs_known (file_generic) sources=upload,remote,reference"
