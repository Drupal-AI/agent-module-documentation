#!/usr/bin/env bash
# Introspection SETUP: create an interval field field_interval_periods on Article and
# restrict its interval_default widget's allowed_periods to day/week/month on the default
# form display, so an inspecting agent can read back which periods the widget offers.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_interval_periods")) {
    FieldStorageConfig::create([
      "field_name" => "field_interval_periods", "entity_type" => "node", "type" => "interval",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_interval_periods")) {
    FieldConfig::create([
      "field_name" => "field_interval_periods", "entity_type" => "node",
      "bundle" => "article", "label" => "Restricted Duration",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_interval_periods", [
    "type" => "interval_default", "weight" => 50, "region" => "content",
    "settings" => ["allowed_periods" => ["day" => "day", "week" => "week", "month" => "month"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_interval_periods widget allowed_periods = day,week,month"
