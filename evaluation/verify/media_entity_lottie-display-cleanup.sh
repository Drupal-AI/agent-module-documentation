#!/usr/bin/env bash
# Cleanup: delete media type 'mel_disp' plus its source field/storage and displays. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  $id = "mel_disp";
  if ($t = MediaType::load($id)) {
    $sf = $t->getSource()->getConfiguration()["source_field"] ?? NULL;
    foreach (["entity_view_display","entity_form_display"] as $dt) {
      if ($d = \Drupal::entityTypeManager()->getStorage($dt)->load("media.$id.default")) { $d->delete(); }
    }
    $t->delete();
    if ($sf) {
      if ($fc = FieldConfig::loadByName("media", $id, $sf)) { $fc->delete(); }
      if ($fsc = FieldStorageConfig::loadByName("media", $sf)) { if (count($fsc->getBundles()) === 0) { $fsc->delete(); } }
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media type mel_disp removed"
