#!/usr/bin/env bash
# Execution RESET: ensure field_isbn_fmt exists on Article with the PLAIN formatter
# (isbn_default), so verify FAILs until the agent switches it to isbn_formatted_formatter.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_isbn_fmt")) {
    FieldStorageConfig::create(["field_name" => "field_isbn_fmt", "entity_type" => "node", "type" => "isbn"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_isbn_fmt")) {
    FieldConfig::create(["field_name" => "field_isbn_fmt", "entity_type" => "node", "bundle" => "article", "label" => "ISBN fmt"])->save();
  }
  \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default")
    ->setComponent("field_isbn_fmt", ["type" => "isbn_default", "weight" => 51, "region" => "content"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_isbn_fmt formatter = isbn_default"
