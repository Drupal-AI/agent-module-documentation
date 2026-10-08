#!/usr/bin/env bash
# Introspection SETUP: add a KNOWN yearonly field to node:article so an inspecting agent can
# read its range settings back with drush. Field field_year_intro has yearonly_from=1950 and
# yearonly_to=now. The field does not ship by default, so it is safe to create/delete.
# Idempotent (recreated each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_year_intro")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_year_intro",
      "entity_type" => "node",
      "type" => "yearonly",
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_year_intro")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_year_intro",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Intro year",
      "settings" => ["yearonly_from" => "1950", "yearonly_to" => "now"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_year_intro (yearonly, from=1950 to=now) created"
