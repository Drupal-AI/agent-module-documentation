#!/usr/bin/env bash
# Execution RESET (video_embed_facebook): ensure field_vef_show (video_embed_field) exists on Article
# but NO vef_show node, so verify FAILS until the agent adds an article embedding the Facebook video.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if(!FieldStorageConfig::loadByName("node","field_vef_show")){FieldStorageConfig::create(["field_name"=>"field_vef_show","entity_type"=>"node","type"=>"video_embed_field"])->save();}
  if(!FieldConfig::loadByName("node","article","field_vef_show")){FieldConfig::create(["field_name"=>"field_vef_show","entity_type"=>"node","bundle"=>"article","label"=>"Show FB Video"])->save();}
  foreach(\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"vef_show"]) as $n){$n->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_vef_show present, no vef_show node"
