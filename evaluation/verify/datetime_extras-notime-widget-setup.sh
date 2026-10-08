#!/usr/bin/env bash
# Introspection SETUP: create a core datetime field on Article and set its default form-display
# widget to datetime_extras' 'Select list, no time' (datetime_datelist_no_time) so an agent can
# read back the widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dte_when")) {
    FieldStorageConfig::create([
      "field_name" => "field_dte_when", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_dte_when")) {
    FieldConfig::create([
      "field_name" => "field_dte_when", "entity_type" => "node",
      "bundle" => "article", "label" => "When",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dte_when", [
    "type" => "datetime_datelist_no_time", "region" => "content", "weight" => 50,
    "settings" => ["date_order" => "YMD", "time_type" => "24", "increment" => "15", "date_year_range" => "-3:+3"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_dte_when widget=datetime_datelist_no_time"
