#!/usr/bin/env bash
# Introspection SETUP: address field linked to OpenStreetMap, opening in a new window. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_aml_win")) {
    FieldStorageConfig::create(["field_name"=>"field_aml_win","entity_type"=>"node","type"=>"address"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_aml_win")) {
    FieldConfig::create(["field_name"=>"field_aml_win","entity_type"=>"node","bundle"=>"article","label"=>"Venue"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_aml_win", ["type"=>"address_default","weight"=>61,"region"=>"content",
    "third_party_settings"=>["address_map_link"=>["link_address"=>TRUE,"map_link_type"=>"openstreetmap","map_link_position"=>"address","map_link_text"=>"Open Map","map_link_new_window"=>TRUE]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_aml_win linked to openstreetmap (new window)"
