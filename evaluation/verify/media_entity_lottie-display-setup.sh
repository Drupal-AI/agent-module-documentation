#!/usr/bin/env bash
# Introspection SETUP: create media type 'mel_disp' (lottie_file) and configure its Lottie player
# display formatter with distinctive settings speed=3, hover=TRUE. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  if (!MediaType::load("mel_disp")) {
    $t = MediaType::create(["id"=>"mel_disp","label"=>"MEL Disp","source"=>"lottie_file"]);
    $t->save();
    $field = $t->getSource()->createSourceField($t);
    $fsc = $field->getFieldStorageDefinition();
    if ($fsc->isNew()) { $fsc->save(); }
    if ($field->isNew()) { $field->save(); }
    $t->set("source_configuration", ["source_field"=>$field->getName()])->save();
  }
  $t = MediaType::load("mel_disp");
  $sf = $t->getSource()->getConfiguration()["source_field"];
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.mel_disp.default");
  if (!$vd) { $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->create(["targetEntityType"=>"media","bundle"=>"mel_disp","mode"=>"default","status"=>TRUE]); }
  $vd->setComponent($sf, ["type"=>"file_lottie_player","label"=>"visually_hidden","settings"=>["speed"=>3,"hover"=>TRUE]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type mel_disp with Lottie player display speed=3 hover=TRUE"
