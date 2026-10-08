#!/usr/bin/env bash
# Introspection SETUP: create two string fields on Article, field_ufa_on (marked unique) and
# field_ufa_off (not unique), so an inspecting agent must read config to tell which enforces
# uniqueness. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_ufa_on" => "On Field", "field_ufa_off" => "Off Field"] as $fn => $label) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"string","cardinality"=>1])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>$label])->save();
    }
  }
  $on = FieldConfig::loadByName("node", "article", "field_ufa_on");
  $on->setThirdPartySetting("unique_field_ajax", "unique", 1);
  $on->save();
  // Ensure field_ufa_off has no unique_field_ajax setting.
  $off = FieldConfig::loadByName("node", "article", "field_ufa_off");
  $off->unsetThirdPartySetting("unique_field_ajax", "unique");
  $off->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ufa_on unique=1, field_ufa_off has no unique setting"
