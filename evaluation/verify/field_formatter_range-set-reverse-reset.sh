#!/usr/bin/env bash
# Execution RESET: ensure multi-value string field field_ffr_period exists on Article with a
# default-view-display formatter and order=0 (not reversed), so verify FAILS until the agent
# sets order=1. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ffr_period")) {
    FieldStorageConfig::create(["field_name"=>"field_ffr_period","entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ffr_period")) {
    FieldConfig::create(["field_name"=>"field_ffr_period","entity_type"=>"node","bundle"=>"article","label"=>"FFR Period"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ffr_period", ["type"=>"string","weight"=>50,"region"=>"content","label"=>"above","third_party_settings"=>["field_formatter_range"=>["order"=>0,"limit"=>0,"offset"=>0]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ffr_period present with field_formatter_range.order=0"
