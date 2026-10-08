#!/usr/bin/env bash
# Introspection SETUP: add field_miu_known (string) to menu_link_content. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("menu_link_content", "field_miu_known")) {
    FieldStorageConfig::create(["field_name" => "field_miu_known", "entity_type" => "menu_link_content", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("menu_link_content", "menu_link_content", "field_miu_known")) {
    FieldConfig::create(["field_name" => "field_miu_known", "entity_type" => "menu_link_content", "bundle" => "menu_link_content", "label" => "Known"])->save();
  }
' >/dev/null 2>&1
echo "setup: field_miu_known added to menu_link_content"
