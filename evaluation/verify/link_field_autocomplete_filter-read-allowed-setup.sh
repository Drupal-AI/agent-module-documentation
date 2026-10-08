#!/usr/bin/env bash
# Introspection SETUP: link field on lfaf_m1 with include mode allowing only 'page'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("lfaf_m1")) { NodeType::create(["type" => "lfaf_m1", "name" => "lfaf_m1"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_lfaf_m1")) {
    FieldStorageConfig::create(["field_name" => "field_lfaf_m1", "entity_type" => "node", "type" => "link"])->save();
  }
  $fc = FieldConfig::loadByName("node", "lfaf_m1", "field_lfaf_m1");
  if (!$fc) { $fc = FieldConfig::create(["field_name" => "field_lfaf_m1", "entity_type" => "node", "bundle" => "lfaf_m1", "label" => "field_lfaf_m1"]); }
  $fc->setThirdPartySetting("link_field_autocomplete_filter", "negate", FALSE); $fc->setThirdPartySetting("link_field_autocomplete_filter", "allowed_content_types", ["page" => "page"]);
  $fc->save();
' >/dev/null 2>&1
echo "setup: node.lfaf_m1 field field_lfaf_m1 ready"
