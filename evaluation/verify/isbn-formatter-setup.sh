#!/usr/bin/env bash
# Introspection SETUP: add ISBN field field_isbn_disp to Article and set its display
# formatter to isbn_formatted_formatter, so an agent can read back the configured formatter.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_isbn_disp")) {
    FieldStorageConfig::create(["field_name" => "field_isbn_disp", "entity_type" => "node", "type" => "isbn"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_isbn_disp")) {
    FieldConfig::create(["field_name" => "field_isbn_disp", "entity_type" => "node", "bundle" => "article", "label" => "ISBN display"])->save();
  }
  \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default")
    ->setComponent("field_isbn_disp", ["type" => "isbn_formatted_formatter", "weight" => 50, "region" => "content"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_isbn_disp display formatter = isbn_formatted_formatter"
