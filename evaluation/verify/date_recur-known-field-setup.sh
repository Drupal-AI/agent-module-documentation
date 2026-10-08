#!/usr/bin/env bash
# Introspection SETUP: add a KNOWN date_recur field to node:article so an inspecting agent can
# read its configuration back with drush. Field field_recur_intro is restricted (parts grid) to
# the WEEKLY frequency only, with a distinctive precreate interval of P3Y. The field does not
# ship by default, so it is safe to create/delete. Idempotent (recreated each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_recur_intro")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_recur_intro",
      "entity_type" => "node",
      "type" => "date_recur",
      "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_recur_intro")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_recur_intro",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Intro recurring date",
      "settings" => [
        "precreate" => "P3Y",
        "parts" => ["all" => FALSE, "frequencies" => ["WEEKLY" => ["INTERVAL", "BYDAY", "COUNT", "UNTIL"]]],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_recur_intro (WEEKLY only, precreate P3Y) created"
