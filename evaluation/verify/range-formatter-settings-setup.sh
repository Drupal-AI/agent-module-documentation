#!/usr/bin/env bash
# Introspection SETUP: create a Range (integer) field field_range_ages on Article and point the
# default view display at the 'Formatted string' formatter (range_integer_sprintf) with a known
# format_string and range_separator, so an agent can read the live display config back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_range_ages")) {
    FieldStorageConfig::create([
      "field_name" => "field_range_ages", "entity_type" => "node", "type" => "range_integer",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_range_ages")) {
    FieldConfig::create([
      "field_name" => "field_range_ages", "entity_type" => "node",
      "bundle" => "article", "label" => "Age Range",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_range_ages", ["type" => "range", "weight" => 61, "region" => "content"])->save();
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_range_ages", [
    "type" => "range_integer_sprintf",
    "label" => "above",
    "weight" => 61,
    "region" => "content",
    "settings" => [
      "range_separator" => " up to ",
      "format_string" => "%03d",
      "range_combine" => FALSE,
      "field_prefix_suffix" => FALSE,
      "from_prefix_suffix" => TRUE,
      "to_prefix_suffix" => TRUE,
      "combined_prefix_suffix" => FALSE,
    ],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_range_ages displayed with range_integer_sprintf format_string=%03d separator=' up to '"
