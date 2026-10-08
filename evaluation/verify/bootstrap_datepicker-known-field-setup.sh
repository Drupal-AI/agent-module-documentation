#!/usr/bin/env bash
# Introspection SETUP: create two datetime fields on Article — field_bsd_on using the
# bootstrap_date_widget and field_bsd_off using the core datetime_default widget — so the agent
# must inspect the live form display to tell which uses Bootstrap Datepicker. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_bsd_on","field_bsd_off"] as $fn) {
    if (!FieldStorageConfig::loadByName("node",$fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>($fn==="field_bsd_on"?"BSD On":"BSD Off")])->save();
    }
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bsd_on", ["type"=>"bootstrap_date_widget","weight"=>50,"region"=>"content","settings"=>[]]);
  $fd->setComponent("field_bsd_off", ["type"=>"datetime_default","weight"=>51,"region"=>"content","settings"=>[]]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_bsd_on uses bootstrap_date_widget, field_bsd_off uses datetime_default"
