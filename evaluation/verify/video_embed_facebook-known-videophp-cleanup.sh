#!/usr/bin/env bash
# Introspection CLEANUP (video_embed_facebook): remove node vef_alt and field_vef_alt. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  foreach(\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"vef_alt"]) as $n){$n->delete();}
  if($fc=FieldConfig::loadByName("node","article","field_vef_alt")){$fc->delete();}
  if($fs=FieldStorageConfig::loadByName("node","field_vef_alt")){$fs->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vef_alt node/field removed"
