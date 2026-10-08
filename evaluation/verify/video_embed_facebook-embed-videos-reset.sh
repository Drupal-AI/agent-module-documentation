#!/usr/bin/env bash
# Execution RESET (video_embed_facebook): remove field_vef_task and any vef_task node so verify FAILS
# on empty state (agent must create the video_embed_field field AND a node with a Facebook URL).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  foreach(\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"vef_task"]) as $n){$n->delete();}
  if($fc=FieldConfig::loadByName("node","article","field_vef_task")){$fc->delete();}
  if($fs=FieldStorageConfig::loadByName("node","field_vef_task")){$fs->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no field_vef_task, no vef_task node"
