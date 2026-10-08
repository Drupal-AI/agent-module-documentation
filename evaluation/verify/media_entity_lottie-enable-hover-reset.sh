#!/usr/bin/env bash
# Execution RESET: ensure media type 'mel_task' exists (lottie_file) with its Lottie player display
# formatter present but hover=FALSE, so verify FAILS until the agent turns hover on. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  if (!MediaType::load("mel_task")) {
    $t = MediaType::create(["id"=>"mel_task","label"=>"MEL Task","source"=>"lottie_file"]);
    $t->save();
    $field = $t->getSource()->createSourceField($t);
    $fsc = $field->getFieldStorageDefinition();
    if ($fsc->isNew()) { $fsc->save(); }
    if ($field->isNew()) { $field->save(); }
    $t->set("source_configuration", ["source_field"=>$field->getName()])->save();
  }
  $t = MediaType::load("mel_task");
  $sf = $t->getSource()->getConfiguration()["source_field"];
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.mel_task.default");
  if (!$vd) { $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->create(["targetEntityType"=>"media","bundle"=>"mel_task","mode"=>"default","status"=>TRUE]); }
  $vd->setComponent($sf, ["type"=>"file_lottie_player","label"=>"visually_hidden","settings"=>["hover"=>FALSE]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media type mel_task with Lottie player display hover=FALSE"
