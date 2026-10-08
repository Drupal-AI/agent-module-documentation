#!/usr/bin/env bash
# Execution RESET: create media type mes_fixed with the slideshow source but NO source field mapped
# and no field_mes_slides field, so verify FAILS until the agent adds the entity_reference field
# field_mes_slides and maps it as the source_field.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("media","mes_fixed","field_mes_slides")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media","field_mes_slides")) { $fs->delete(); }
  $t = MediaType::load("mes_fixed");
  if (!$t) {
    MediaType::create(["id"=>"mes_fixed","label"=>"MES Fixed","source"=>"slideshow","source_configuration"=>["source_field"=>""]])->save();
  } else {
    $t->set("source_configuration",["source_field"=>""])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media type mes_fixed present with slideshow source and no source field"
