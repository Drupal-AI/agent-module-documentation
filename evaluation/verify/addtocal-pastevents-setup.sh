#!/usr/bin/env bash
# Introspection SETUP: two datetime fields both with addtocal_view; field_atc_on shows past
# events (past_events=TRUE), field_atc_off does not (FALSE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_atc_on","field_atc_off"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>ucfirst($fn)])->save();
    }
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_atc_on",  ["type"=>"addtocal_view","label"=>"hidden","weight"=>61,"region"=>"content","settings"=>["past_events"=>TRUE]]);
  $vd->setComponent("field_atc_off", ["type"=>"addtocal_view","label"=>"hidden","weight"=>62,"region"=>"content","settings"=>["past_events"=>FALSE]]);
  $vd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_atc_on past_events=TRUE, field_atc_off past_events=FALSE"
