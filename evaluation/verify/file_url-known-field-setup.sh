#!/usr/bin/env bash
# Introspection SETUP: create a file_url field field_fu_known on Article so an inspecting
# agent can identify which Article field is of type file_url. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fu_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_fu_known", "entity_type" => "node", "type" => "file_url",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fu_known")) {
    FieldConfig::create([
      "field_name" => "field_fu_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Attachment",
    ])->save();
  }
  \Drupal::service("entity_display.repository")->getFormDisplay("node","article")
    ->setComponent("field_fu_known", ["type" => "file_url_generic"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fu_known (type file_url) created"
