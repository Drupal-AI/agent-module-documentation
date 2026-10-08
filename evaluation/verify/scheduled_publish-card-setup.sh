#!/usr/bin/env bash
# Introspection SETUP: scheduled_publish field field_spc on Article with UNLIMITED cardinality,
# so an agent can report how many scheduled transitions it allows.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_spc")) {
    FieldStorageConfig::create(["field_name"=>"field_spc","entity_type"=>"node","type"=>"scheduled_publish","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_spc")) {
    FieldConfig::create(["field_name"=>"field_spc","entity_type"=>"node","bundle"=>"article","label"=>"Scheduled Moderation C"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_spc scheduled_publish cardinality=-1 (unlimited)"
