#!/usr/bin/env bash
# Introspection SETUP: create a daterange_timezone field field_drt_fmt on Article and set the
# single-date formatter (daterange_timezone_single_date) to show the END date, so an agent can
# read back which endpoint the formatter displays. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_drt_fmt")) {
    FieldStorageConfig::create([
      "field_name" => "field_drt_fmt", "entity_type" => "node",
      "type" => "daterange_timezone", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_drt_fmt")) {
    FieldConfig::create([
      "field_name" => "field_drt_fmt", "entity_type" => "node",
      "bundle" => "article", "label" => "Formatted Range",
    ])->save();
  }
  \Drupal::service("entity_display.repository")->getViewDisplay("node","article")
    ->setComponent("field_drt_fmt", [
      "type" => "daterange_timezone_single_date",
      "settings" => ["date_field" => "end_date", "format_type" => "medium", "display_timezone" => TRUE],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_drt_fmt single-date formatter date_field=end_date on node.article view"
