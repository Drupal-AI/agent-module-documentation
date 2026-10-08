#!/usr/bin/env bash
# Introspection SETUP: create a media type (mea_known) that uses the media_entity_audio
# 'audio_stream' source, with its link source field wired up, so an agent can discover which
# media type on the site uses the audio_stream source. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  if (!MediaType::load("mea_known")) {
    $t = MediaType::create(["id"=>"mea_known","label"=>"MEA Known Audio","source"=>"audio_stream","source_configuration"=>[]]);
    $t->save();
    $field = $t->getSource()->createSourceField($t);
    $field->getFieldStorageDefinition()->save();
    $field->save();
    $t->set("source_configuration", ["source_field"=>$field->getName()])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type mea_known uses source audio_stream"
