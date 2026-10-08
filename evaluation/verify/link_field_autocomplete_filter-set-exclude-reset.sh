#!/usr/bin/env bash
# Execution RESET: bare link field on lfaf_h2 (filter cleared) so verify FAILS until configured. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("lfaf_h2")) { NodeType::create(["type" => "lfaf_h2", "name" => "lfaf_h2"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_lfaf_h2")) {
    FieldStorageConfig::create(["field_name" => "field_lfaf_h2", "entity_type" => "node", "type" => "link"])->save();
  }
  $fc = FieldConfig::loadByName("node", "lfaf_h2", "field_lfaf_h2");
  if (!$fc) { $fc = FieldConfig::create(["field_name" => "field_lfaf_h2", "entity_type" => "node", "bundle" => "lfaf_h2", "label" => "field_lfaf_h2"]); }
  $fc->unsetThirdPartySetting("link_field_autocomplete_filter", "negate"); $fc->unsetThirdPartySetting("link_field_autocomplete_filter", "allowed_content_types");
  $fc->save();
' >/dev/null 2>&1
echo "setup: node.lfaf_h2 field field_lfaf_h2 ready"
