#!/usr/bin/env bash
# Introspection SETUP: create a media type (mea_ctrl) using audio_stream and set its source
# field display to the audio_stream_html5 formatter with controls DISABLED, so an agent can
# read back the controls setting from the live view display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  if (!MediaType::load("mea_ctrl")) {
    $t = MediaType::create(["id"=>"mea_ctrl","label"=>"MEA Controls","source"=>"audio_stream","source_configuration"=>[]]);
    $t->save();
    $field = $t->getSource()->createSourceField($t);
    $field->getFieldStorageDefinition()->save();
    $field->save();
    $t->set("source_configuration", ["source_field"=>$field->getName()])->save();
  }
  $t = MediaType::load("mea_ctrl");
  $sf = $t->get("source_configuration")["source_field"];
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.mea_ctrl.default");
  if (!$vd) {
    $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->create(["targetEntityType"=>"media","bundle"=>"mea_ctrl","mode"=>"default","status"=>TRUE]);
  }
  $vd->setComponent($sf, ["type"=>"audio_stream_html5","settings"=>["controls"=>FALSE],"label"=>"visually_hidden","region"=>"content","weight"=>0])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type mea_ctrl source field uses audio_stream_html5 with controls=false"
