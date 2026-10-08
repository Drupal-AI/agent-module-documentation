#!/usr/bin/env bash
# Execution RESET: ensure media type 'mel_build' does NOT exist (delete it + its field), so verify
# FAILS until the agent creates a Lottie media type. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  $id = "mel_build";
  if ($t = MediaType::load($id)) {
    $sf = $t->getSource()->getConfiguration()["source_field"] ?? NULL;
    foreach (["entity_view_display","entity_form_display"] as $dt) { if ($d = \Drupal::entityTypeManager()->getStorage($dt)->load("media.$id.default")) { $d->delete(); } }
    $t->delete();
    if ($sf) { if ($fc = FieldConfig::loadByName("media",$id,$sf)) { $fc->delete(); } if ($fsc = FieldStorageConfig::loadByName("media",$sf)) { if (count($fsc->getBundles())===0) { $fsc->delete(); } } }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media type mel_build removed"
