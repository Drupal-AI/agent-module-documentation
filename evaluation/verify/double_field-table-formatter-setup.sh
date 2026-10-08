#!/usr/bin/env bash
# Introspection SETUP: create a Double Field field_df_hours on Article and display it with the
# double_field_table formatter carrying known column labels and a row-number column, so an agent
# can read the formatter settings back from the live view display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_df_hours");
  if (!$fs) {
    $fs = FieldStorageConfig::create([
      "field_name" => "field_df_hours", "entity_type" => "node",
      "type" => "double_field", "cardinality" => -1,
    ]);
  }
  $fs->setSetting("storage", [
    "first"  => ["type" => "string", "maxlength" => 255, "precision" => 10, "scale" => 2, "datetime_type" => "datetime"],
    "second" => ["type" => "string", "maxlength" => 255, "precision" => 10, "scale" => 2, "datetime_type" => "datetime"],
  ]);
  $fs->save();
  if (!FieldConfig::loadByName("node", "article", "field_df_hours")) {
    FieldConfig::create([
      "field_name" => "field_df_hours", "entity_type" => "node",
      "bundle" => "article", "label" => "Opening Hours",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_df_hours", ["type" => "double_field", "weight" => 72, "region" => "content"])->save();
  $subfield = [
    "hidden" => FALSE, "link" => FALSE, "format_type" => "medium",
    "thousand_separator" => "", "decimal_separator" => ".", "scale" => 2, "key" => FALSE,
  ];
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_df_hours", [
    "type" => "double_field_table",
    "label" => "above",
    "weight" => 72,
    "region" => "content",
    "settings" => [
      "number_column" => TRUE,
      "number_column_label" => "#",
      "first_column_label" => "Weekday",
      "second_column_label" => "Hours",
      "first" => $subfield,
      "second" => $subfield,
    ],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_df_hours displayed with double_field_table, first_column_label=Weekday second_column_label=Hours"
