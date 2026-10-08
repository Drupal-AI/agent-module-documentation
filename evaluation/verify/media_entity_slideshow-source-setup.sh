#!/usr/bin/env bash
# Introspection SETUP: create media type mes_show using the slideshow source (+ a slides field).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("media","field_mes_show")) {
    FieldStorageConfig::create(["field_name"=>"field_mes_show","entity_type"=>"media","type"=>"entity_reference","cardinality"=>-1,"settings"=>["target_type"=>"media"]])->save();
  }
  if (!MediaType::load("mes_show")) {
    MediaType::create(["id"=>"mes_show","label"=>"MES Show","source"=>"slideshow","source_configuration"=>["source_field"=>"field_mes_show"]])->save();
  }
  if (!FieldConfig::loadByName("media","mes_show","field_mes_show")) {
    FieldConfig::create(["field_name"=>"field_mes_show","entity_type"=>"media","bundle"=>"mes_show","label"=>"Slides"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type mes_show (source=slideshow) created"
