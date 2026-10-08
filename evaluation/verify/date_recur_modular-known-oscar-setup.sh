#!/usr/bin/env bash
# Introspection SETUP: add a KNOWN date_recur field to node:article and set its form-display
# widget to the Date Recur Modular "Oscar" (opening-hours) widget (date_recur_modular_oscar),
# with its all_day_toggle setting DISABLED so an inspecting agent can read both the widget id
# and the distinctive setting back with drush. Safe to create/delete (not shipped by default).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_recur_hours")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_recur_hours",
      "entity_type" => "node",
      "type" => "date_recur",
      "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_recur_hours")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_recur_hours",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Opening hours",
    ])->save();
  }
  \Drupal::service("entity_display.repository")
    ->getFormDisplay("node", "article", "default")
    ->setComponent("field_recur_hours", [
      "type" => "date_recur_modular_oscar",
      "settings" => ["all_day_toggle" => FALSE],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_recur_hours form widget = date_recur_modular_oscar (all_day_toggle off)"
