#!/usr/bin/env bash
# Introspection SETUP: create a multi-value string field field_ffr_known on Article and set its
# default-view-display formatter with field_formatter_range limit=3, so an inspecting agent can
# read back which field/limit has the setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ffr_known")) {
    FieldStorageConfig::create(["field_name"=>"field_ffr_known","entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ffr_known")) {
    FieldConfig::create(["field_name"=>"field_ffr_known","entity_type"=>"node","bundle"=>"article","label"=>"FFR Known"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ffr_known", [
    "type"=>"string","weight"=>50,"region"=>"content","label"=>"above",
    "third_party_settings"=>["field_formatter_range"=>["order"=>0,"limit"=>3,"offset"=>0]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ffr_known has field_formatter_range.limit=3"
