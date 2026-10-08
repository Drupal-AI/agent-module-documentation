#!/usr/bin/env bash
# Execution CLEANUP (video_embed_facebook): remove field_vef_task and vef_task node. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  foreach(\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"vef_task"]) as $n){$n->delete();}
  if($fc=FieldConfig::loadByName("node","article","field_vef_task")){$fc->delete();}
  if($fs=FieldStorageConfig::loadByName("node","field_vef_task")){$fs->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vef_task node/field removed"
