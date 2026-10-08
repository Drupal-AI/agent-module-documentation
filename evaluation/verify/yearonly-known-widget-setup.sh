#!/usr/bin/env bash
# Introspection SETUP: add a KNOWN yearonly field to node:article AND configure its form
# display widget so an inspecting agent can read the widget setting back. Field
# field_year_widget uses the yearonly_default widget with sort_order=desc (newest first),
# range from=1990 to=now. Does not ship by default; safe to create/delete. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_year_widget")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_year_widget",
      "entity_type" => "node",
      "type" => "yearonly",
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_year_widget")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_year_widget",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Widget year",
      "settings" => ["yearonly_from" => "1990", "yearonly_to" => "now"],
    ])->save();
  }
  \Drupal::service("entity_display.repository")
    ->getFormDisplay("node", "article", "default")
    ->setComponent("field_year_widget", [
      "type" => "yearonly_default",
      "settings" => ["sort_order" => "desc"],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_year_widget (yearonly_default widget, sort_order=desc) created"
