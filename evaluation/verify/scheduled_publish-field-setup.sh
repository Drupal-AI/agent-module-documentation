#!/usr/bin/env bash
# Introspection SETUP: add a scheduled_publish field (field_spx) to Article so an inspecting
# agent can discover which field provides scheduled moderation. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_spx")) {
    FieldStorageConfig::create(["field_name"=>"field_spx","entity_type"=>"node","type"=>"scheduled_publish","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_spx")) {
    FieldConfig::create(["field_name"=>"field_spx","entity_type"=>"node","bundle"=>"article","label"=>"Scheduled Moderation X"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_spx type=scheduled_publish"
