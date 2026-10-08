#!/usr/bin/env bash
# Introspection SETUP (video_embed_facebook): create a video_embed_field field_vef_known on Article
# and a node holding a Facebook /videos/ URL, so an agent can read the stored value and extract the
# Facebook video id. Does NOT render (which would fatal on this VEF version). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig; use Drupal\node\Entity\Node;
  if(!FieldStorageConfig::loadByName("node","field_vef_known")){FieldStorageConfig::create(["field_name"=>"field_vef_known","entity_type"=>"node","type"=>"video_embed_field"])->save();}
  if(!FieldConfig::loadByName("node","article","field_vef_known")){FieldConfig::create(["field_name"=>"field_vef_known","entity_type"=>"node","bundle"=>"article","label"=>"Known FB Video"])->save();}
  foreach(\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"vef_known"]) as $n){$n->delete();}
  Node::create(["type"=>"article","title"=>"vef_known","field_vef_known"=>"https://www.facebook.com/somepage/videos/9876543210"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node vef_known field_vef_known = https://www.facebook.com/somepage/videos/9876543210"
