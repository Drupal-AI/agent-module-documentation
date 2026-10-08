#!/usr/bin/env bash
# Introspection SETUP: create a multi-value string field field_fdlm_tags on Article and set a
# distinctive Field Delimiter (" ~fd~ ") on its formatter in the default view display, so an
# agent can read back which field has a delimiter and what it is. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fdlm_tags")) {
    FieldStorageConfig::create(["field_name"=>"field_fdlm_tags","entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fdlm_tags")) {
    FieldConfig::create(["field_name"=>"field_fdlm_tags","entity_type"=>"node","bundle"=>"article","label"=>"FDLM Tags"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fdlm_tags", ["type"=>"string","weight"=>50,"region"=>"content","third_party_settings"=>["field_delimiter"=>["delimiter"=>" ~fd~ "]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fdlm_tags has field_delimiter.delimiter=' ~fd~ '"
