#!/usr/bin/env bash
# Execution CLEANUP (video_embed_facebook): remove field_vef_show and vef_show node. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  foreach(\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"vef_show"]) as $n){$n->delete();}
  if($fc=FieldConfig::loadByName("node","article","field_vef_show")){$fc->delete();}
  if($fs=FieldStorageConfig::loadByName("node","field_vef_show")){$fs->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vef_show node/field removed"
