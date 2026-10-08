#!/usr/bin/env bash
# Introspection SETUP: create integer field field_rs_known on Article using the range_slider
# widget (orientation=vertical, output=above) on the default form display. Uses the display
# repository so the display is created if it does not yet exist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_rs_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_rs_known", "entity_type" => "node", "type" => "integer",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_rs_known")) {
    FieldConfig::create([
      "field_name" => "field_rs_known", "entity_type" => "node",
      "bundle" => "article", "label" => "RS Known",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_rs_known", [
    "type" => "range_slider", "weight" => 50, "region" => "content",
    "settings" => ["orientation" => "vertical", "output" => "above"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_rs_known (range_slider, orientation=vertical, output=above)"
