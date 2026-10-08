#!/usr/bin/env bash
# Execution RESET: ensure a multi-value image field field_idf_lead exists on Article with the
# CORE 'image' formatter on the default view display, so verify FAILS until the agent switches
# it to image_delta_formatter showing deltas 0 and 1. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_idf_lead")) {
    FieldStorageConfig::create(["field_name" => "field_idf_lead", "entity_type" => "node", "type" => "image", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_idf_lead")) {
    FieldConfig::create(["field_name" => "field_idf_lead", "entity_type" => "node", "bundle" => "article", "label" => "Lead Images"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_idf_lead", [
    "type" => "image", "label" => "hidden", "weight" => 43, "region" => "content",
    "settings" => ["image_style" => "", "image_link" => ""],
  ])->save();
' >/dev/null 2>&1
echo "reset: node.article field_idf_lead uses core image formatter (NOT delta)"
