#!/usr/bin/env bash
# Introspection SETUP: create TWO multi-value string fields on Article — field_ffr_on with
# field_formatter_range order=1 (Reverse) and field_ffr_off with no range setting — so the agent
# must inspect the live view display to tell which reverses. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_ffr_on","field_ffr_off"] as $fn) {
    if (!FieldStorageConfig::loadByName("node",$fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>($fn==="field_ffr_on"?"FFR On":"FFR Off")])->save();
    }
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ffr_on", ["type"=>"string","weight"=>50,"region"=>"content","label"=>"above","third_party_settings"=>["field_formatter_range"=>["order"=>1,"limit"=>0,"offset"=>0]]]);
  $vd->setComponent("field_ffr_off", ["type"=>"string","weight"=>51,"region"=>"content","label"=>"above","third_party_settings"=>[]]);
  $vd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ffr_on order=1 (reverse), field_ffr_off no range setting"
