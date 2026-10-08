#!/usr/bin/env bash
# Execution RESET for "configure the Unformatted range formatter on Article".
# Ensures a Range (decimal) field field_range_fee exists on Article, and forces its default
# view-display component back to the 'Default' formatter (range_decimal) with the module's own
# defaults (range_separator '-', range_combine TRUE, all prefix/suffix toggles off) so verify
# FAILS until the agent switches it to range_unformatted with the requested settings.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_range_fee")) {
    FieldStorageConfig::create([
      "field_name" => "field_range_fee", "entity_type" => "node",
      "type" => "range_decimal", "settings" => ["precision" => 10, "scale" => 2],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_range_fee");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_range_fee", "entity_type" => "node",
      "bundle" => "article", "label" => "Consulting Fee",
    ]);
  }
  $fc->setSettings([
    "min" => "", "max" => "",
    "field" => ["prefix" => "", "suffix" => ""],
    "from" => ["prefix" => "EUR ", "suffix" => ""],
    "to" => ["prefix" => "EUR ", "suffix" => ""],
    "combined" => ["prefix" => "EUR ", "suffix" => " flat"],
  ])->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_range_fee", ["type" => "range", "weight" => 63, "region" => "content"])->save();
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_range_fee", [
    "type" => "range_decimal",
    "label" => "above",
    "weight" => 63,
    "region" => "content",
    "settings" => [
      "range_separator" => "-",
      "thousand_separator" => "",
      "decimal_separator" => ".",
      "scale" => 2,
      "range_combine" => TRUE,
      "field_prefix_suffix" => FALSE,
      "from_prefix_suffix" => FALSE,
      "to_prefix_suffix" => FALSE,
      "combined_prefix_suffix" => FALSE,
    ],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_range_fee displayed with range_decimal defaults (separator '-', combined_prefix_suffix off)"
