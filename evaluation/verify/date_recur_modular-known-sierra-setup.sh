#!/usr/bin/env bash
# Introspection SETUP: add a KNOWN date_recur field to node:article and set its form-display
# widget to the Date Recur Modular "Sierra" widget (date_recur_modular_sierra), so an inspecting
# agent can read the assigned widget back with drush. The field does not ship by default, so it
# is safe to create/delete. Idempotent (recreated each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_recur_disp")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_recur_disp",
      "entity_type" => "node",
      "type" => "date_recur",
      "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_recur_disp")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_recur_disp",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Display recurring date",
    ])->save();
  }
  \Drupal::service("entity_display.repository")
    ->getFormDisplay("node", "article", "default")
    ->setComponent("field_recur_disp", [
      "type" => "date_recur_modular_sierra",
      "settings" => ["interpreter" => "", "date_format_type" => "medium", "occurrences_modal" => TRUE],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_recur_disp form widget = date_recur_modular_sierra"
