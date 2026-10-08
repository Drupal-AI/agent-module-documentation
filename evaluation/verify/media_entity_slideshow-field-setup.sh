#!/usr/bin/env bash
# Introspection SETUP: create media type mes_gallery (slideshow source) whose source_field is
# field_mes_items, so an agent can read the source field machine name.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("media","field_mes_items")) {
    FieldStorageConfig::create(["field_name"=>"field_mes_items","entity_type"=>"media","type"=>"entity_reference","cardinality"=>-1,"settings"=>["target_type"=>"media"]])->save();
  }
  if (!MediaType::load("mes_gallery")) {
    MediaType::create(["id"=>"mes_gallery","label"=>"MES Gallery","source"=>"slideshow","source_configuration"=>["source_field"=>"field_mes_items"]])->save();
  }
  if (!FieldConfig::loadByName("media","mes_gallery","field_mes_items")) {
    FieldConfig::create(["field_name"=>"field_mes_items","entity_type"=>"media","bundle"=>"mes_gallery","label"=>"Items"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type mes_gallery source_field=field_mes_items"
