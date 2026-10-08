#!/usr/bin/env bash
# Introspection SETUP (video_embed_facebook): create field_vef_alt on Article and a node holding a
# Facebook video.php?v= URL, so an agent can read it back and extract the id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig; use Drupal\node\Entity\Node;
  if(!FieldStorageConfig::loadByName("node","field_vef_alt")){FieldStorageConfig::create(["field_name"=>"field_vef_alt","entity_type"=>"node","type"=>"video_embed_field"])->save();}
  if(!FieldConfig::loadByName("node","article","field_vef_alt")){FieldConfig::create(["field_name"=>"field_vef_alt","entity_type"=>"node","bundle"=>"article","label"=>"Alt FB Video"])->save();}
  foreach(\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"vef_alt"]) as $n){$n->delete();}
  Node::create(["type"=>"article","title"=>"vef_alt","field_vef_alt"=>"https://www.facebook.com/video.php?v=1234567890"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node vef_alt field_vef_alt = https://www.facebook.com/video.php?v=1234567890"
