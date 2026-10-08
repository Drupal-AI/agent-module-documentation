#!/usr/bin/env bash
# MEDIUM introspection SETUP: add hierarchy field field_eh_hw to Article and configure its
# autocomplete widget on the default form display with hide_weight = TRUE. Storage is created
# in its own process first (see known-field-setup for why).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  if (!FieldStorageConfig::loadByName("node", "field_eh_hw")) {
    FieldStorageConfig::create([
      "field_name" => "field_eh_hw", "entity_type" => "node",
      "type" => "entity_reference_hierarchy", "cardinality" => 1,
      "settings" => ["target_type" => "node"],
    ])->save();
  }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  if (!FieldConfig::loadByName("node", "article", "field_eh_hw")) {
    FieldConfig::create([
      "field_name" => "field_eh_hw", "entity_type" => "node", "bundle" => "article",
      "label" => "Parent (hidden weight)",
      "settings" => ["handler" => "default:node", "handler_settings" => []],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_eh_hw", [
    "type" => "entity_reference_hierarchy_autocomplete", "weight" => 60, "region" => "content",
    "settings" => ["hide_weight" => TRUE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_eh_hw autocomplete widget hide_weight=TRUE on node.article.default"
