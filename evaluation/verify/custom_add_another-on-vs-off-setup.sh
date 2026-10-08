#!/usr/bin/env bash
# Introspection SETUP: content type caa_onoff with two unlimited string fields; field_caa_on has a
# custom 'Add another' label, field_caa_off has none. Agent must tell which one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("caa_onoff")) { NodeType::create(["type"=>"caa_onoff","name"=>"CAA OnOff"])->save(); }
  foreach (["field_caa_on","field_caa_off"] as $fn) {
    if (!FieldStorageConfig::loadByName("node",$fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
    }
    if (!FieldConfig::loadByName("node","caa_onoff",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"caa_onoff","label"=>$fn])->save();
    }
  }
  $on = FieldConfig::loadByName("node","caa_onoff","field_caa_on");
  $on->setThirdPartySetting("custom_add_another","custom_add_another","Add another widget");
  $on->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_caa_on has a custom add-another label, field_caa_off does not"
