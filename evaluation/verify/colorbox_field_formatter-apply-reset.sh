#!/usr/bin/env bash
# Execution RESET: ensure a string field field_cff_task exists on Article and is displayed with
# the PLAIN core 'string' formatter (NOT the Colorbox formatter), so verify FAILS until the agent
# switches it to colorbox_field_formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cff_task")) {
    FieldStorageConfig::create(["field_name"=>"field_cff_task","entity_type"=>"node","type"=>"string","cardinality"=>1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_cff_task")) {
    FieldConfig::create(["field_name"=>"field_cff_task","entity_type"=>"node","bundle"=>"article","label"=>"CFF Task"])->save();
  }
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_cff_task", [
    "type" => "string",
    "settings" => ["link_to_entity"=>false],
    "region" => "content", "weight" => 22,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_cff_task displayed with plain string formatter"
