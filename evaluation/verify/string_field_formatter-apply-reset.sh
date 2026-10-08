#!/usr/bin/env bash
# Execution RESET: ensure a string field field_sff_task exists on Article, but formatted with
# the DEFAULT core 'string' formatter (NOT plain_string_formatter), so verify FAILS until the
# agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_sff_task")) {
    FieldStorageConfig::create(["field_name" => "field_sff_task", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_sff_task")) {
    FieldConfig::create(["field_name" => "field_sff_task", "entity_type" => "node", "bundle" => "article", "label" => "SFF Task"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_sff_task", ["type" => "string", "weight" => 52, "region" => "content", "label" => "above", "settings" => ["link_to_entity" => FALSE]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_sff_task uses core 'string' formatter"
