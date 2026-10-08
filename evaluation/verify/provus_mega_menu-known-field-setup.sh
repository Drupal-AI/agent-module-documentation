#!/usr/bin/env bash
# Introspection SETUP: attach the Provus mega-menu callout link field
# (field_provus_menu_callout_link) to the menu_link_content 'main' bundle, so an inspecting
# agent can find the field the module's callout uses. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("menu_link_content", "field_provus_menu_callout_link")) {
    FieldStorageConfig::create([
      "field_name" => "field_provus_menu_callout_link", "entity_type" => "menu_link_content",
      "type" => "link", "cardinality" => 1,
    ])->save();
  }
  if (!FieldConfig::loadByName("menu_link_content", "main", "field_provus_menu_callout_link")) {
    FieldConfig::create([
      "field_name" => "field_provus_menu_callout_link", "entity_type" => "menu_link_content",
      "bundle" => "main", "label" => "Callout link",
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: field_provus_menu_callout_link attached to menu_link_content:main"
