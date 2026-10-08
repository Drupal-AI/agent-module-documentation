#!/usr/bin/env bash
# Introspection SETUP: add a social_links field field_slf_known to Article so an inspecting agent
# can find which field on Article is of type social_links. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_slf_known")) {
    FieldStorageConfig::create(["field_name"=>"field_slf_known","entity_type"=>"node","type"=>"social_links","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_slf_known")) {
    FieldConfig::create(["field_name"=>"field_slf_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Social Links"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_slf_known (type social_links) created"
