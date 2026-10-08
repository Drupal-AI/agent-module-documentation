#!/usr/bin/env bash
# Introspection SETUP: add an interval field field_interval_dur to Article so an inspecting
# agent can identify the interval field and its machine name. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_interval_dur")) {
    FieldStorageConfig::create([
      "field_name" => "field_interval_dur", "entity_type" => "node", "type" => "interval",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_interval_dur")) {
    FieldConfig::create([
      "field_name" => "field_interval_dur", "entity_type" => "node",
      "bundle" => "article", "label" => "Membership Duration",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article has interval field field_interval_dur"
