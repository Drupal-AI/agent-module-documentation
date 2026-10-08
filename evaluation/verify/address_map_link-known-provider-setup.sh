#!/usr/bin/env bash
# Introspection SETUP: create an address field on Article, add the address_map_link map link to its
# default view-display formatter with a known provider, so an agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_aml_known")) {
    FieldStorageConfig::create(["field_name"=>"field_aml_known","entity_type"=>"node","type"=>"address"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_aml_known")) {
    FieldConfig::create(["field_name"=>"field_aml_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Location"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_aml_known", ["type"=>"address_default","weight"=>60,"region"=>"content",
    "third_party_settings"=>["address_map_link"=>["link_address"=>TRUE,"map_link_type"=>"waze_directions","map_link_position"=>"after","map_link_text"=>"Directions","map_link_new_window"=>TRUE]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_aml_known linked to waze_directions"
