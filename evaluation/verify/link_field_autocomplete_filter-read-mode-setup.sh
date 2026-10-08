#!/usr/bin/env bash
# Introspection SETUP: link field on lfaf_m2 with exclude mode targeting 'article'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("lfaf_m2")) { NodeType::create(["type" => "lfaf_m2", "name" => "lfaf_m2"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_lfaf_m2")) {
    FieldStorageConfig::create(["field_name" => "field_lfaf_m2", "entity_type" => "node", "type" => "link"])->save();
  }
  $fc = FieldConfig::loadByName("node", "lfaf_m2", "field_lfaf_m2");
  if (!$fc) { $fc = FieldConfig::create(["field_name" => "field_lfaf_m2", "entity_type" => "node", "bundle" => "lfaf_m2", "label" => "field_lfaf_m2"]); }
  $fc->setThirdPartySetting("link_field_autocomplete_filter", "negate", TRUE); $fc->setThirdPartySetting("link_field_autocomplete_filter", "allowed_content_types", ["article" => "article"]);
  $fc->save();
' >/dev/null 2>&1
echo "setup: node.lfaf_m2 field field_lfaf_m2 ready"
