#!/usr/bin/env bash
# Introspection SETUP: create a Range (float) field field_range_span on Article and configure
# the 'range' widget on the default form display with known FROM/TO labels and placeholders,
# so an agent can read the widget settings back from the live form display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_range_span")) {
    FieldStorageConfig::create([
      "field_name" => "field_range_span", "entity_type" => "node", "type" => "range_float",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_range_span")) {
    FieldConfig::create([
      "field_name" => "field_range_span", "entity_type" => "node",
      "bundle" => "article", "label" => "Distance Span",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_range_span", [
    "type" => "range",
    "weight" => 62,
    "region" => "content",
    "settings" => [
      "label" => ["from" => "Shortest", "to" => "Longest"],
      "placeholder" => ["from" => "0.5", "to" => "42.0"],
    ],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_range_span range widget label.from=Shortest label.to=Longest"
