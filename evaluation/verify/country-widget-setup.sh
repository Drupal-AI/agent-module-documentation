#!/usr/bin/env bash
# Introspection SETUP: create a country field and set its form widget to country_autocomplete
# with a known placeholder. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ctry_widget")) {
    FieldStorageConfig::create(["field_name"=>"field_ctry_widget","entity_type"=>"node","type"=>"country"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ctry_widget")) {
    FieldConfig::create(["field_name"=>"field_ctry_widget","entity_type"=>"node","bundle"=>"article","label"=>"Widget Country"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ctry_widget", [
    "type"=>"country_autocomplete","weight"=>50,"region"=>"content",
    "settings"=>["size"=>60,"placeholder"=>"Start typing a country","autocomplete_route_name"=>"country.autocomplete"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ctry_widget uses country_autocomplete widget, placeholder='Start typing a country'"
