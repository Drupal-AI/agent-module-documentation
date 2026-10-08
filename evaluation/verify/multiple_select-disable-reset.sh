#!/usr/bin/env bash
# Execution RESET: field_ms_off exists and IS registered in multiple_select.settings, so verify
# (which passes only when it is NOT registered) FAILS until the agent removes it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ms_off")) {
    FieldStorageConfig::create(["field_name"=>"field_ms_off","entity_type"=>"node","type"=>"list_string","cardinality"=>-1,"settings"=>["allowed_values"=>["p"=>"P","q"=>"Q"]]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ms_off")) {
    FieldConfig::create(["field_name"=>"field_ms_off","entity_type"=>"node","bundle"=>"article","label"=>"Off Field"])->save();
  }
  \Drupal::configFactory()->getEditable("multiple_select.settings")->set("table", json_encode(["node-article"=>["field_ms_off"]]))->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ms_off present AND registered in multiple_select.settings"
