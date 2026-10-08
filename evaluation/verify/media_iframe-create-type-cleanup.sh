#!/usr/bin/env bash
# Execution CLEANUP: ensure media type "mi_task" does NOT exist, so the verify
# script fails until the agent creates it with the inline_frame source. Also drops the default
# source-field storage if it is orphaned. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  $tid="mi_task";
  foreach (\Drupal::entityTypeManager()->getStorage("field_config")->loadByProperties(["entity_type"=>"media","bundle"=>$tid]) as $fc) { $fc->delete(); }
  \Drupal::configFactory()->getEditable("media.type.$tid")->delete();
  if (($fs=FieldStorageConfig::loadByName("media","field_media_inline_frame")) && !$fs->getBundles()) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media type mi_task removed"
