#!/usr/bin/env bash
# Execution RESET: create media type mea_show (audio_stream) and set its source field display to
# the audio_stream_html5 formatter with controls DISABLED, so verify FAILS until the agent turns
# controls on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  if (!MediaType::load("mea_show")) {
    $t = MediaType::create(["id"=>"mea_show","label"=>"MEA Show","source"=>"audio_stream","source_configuration"=>[]]);
    $t->save();
    $field = $t->getSource()->createSourceField($t);
    $field->getFieldStorageDefinition()->save();
    $field->save();
    $t->set("source_configuration", ["source_field"=>$field->getName()])->save();
  }
  $t = MediaType::load("mea_show");
  $sf = $t->get("source_configuration")["source_field"];
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.mea_show.default");
  if (!$vd) { $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->create(["targetEntityType"=>"media","bundle"=>"mea_show","mode"=>"default","status"=>TRUE]); }
  $vd->setComponent($sf, ["type"=>"audio_stream_html5","settings"=>["controls"=>FALSE],"label"=>"visually_hidden","region"=>"content","weight"=>0])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media type mea_show source field uses audio_stream_html5 with controls=false"
