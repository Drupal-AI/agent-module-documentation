#!/usr/bin/env bash
# Execution RESET: ensure a text field field_ti_head exists on Article and its default view
# display uses a NON-Textimage formatter (text_default), so verify FAILS until the agent
# switches it to the Textimage text formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ti_head")) {
    FieldStorageConfig::create([
      "field_name" => "field_ti_head", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ti_head")) {
    FieldConfig::create([
      "field_name" => "field_ti_head", "entity_type" => "node",
      "bundle" => "article", "label" => "Textimage Heading",
    ])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $vd->setComponent("field_ti_head", ["type" => "string", "label" => "hidden", "region" => "content", "weight" => 50])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ti_head present with non-textimage (string) formatter"
