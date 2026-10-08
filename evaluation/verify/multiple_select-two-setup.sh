#!/usr/bin/env bash
# Introspection SETUP: register the helper for TWO fields on Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_ms_a","field_ms_b"] as $fn) {
    if (!FieldStorageConfig::loadByName("node",$fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"list_string","cardinality"=>-1,"settings"=>["allowed_values"=>["p"=>"P","q"=>"Q"]]])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>strtoupper($fn)])->save();
    }
  }
  \Drupal::configFactory()->getEditable("multiple_select.settings")->set("table", json_encode(["node-article"=>["field_ms_a","field_ms_b"]]))->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: multiple_select helper enabled for field_ms_a and field_ms_b on node-article"
