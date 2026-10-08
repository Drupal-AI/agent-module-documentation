#!/usr/bin/env bash
# Introspection SETUP: add image field field_ag_gallery to Article using the animated_gif_image_url
# formatter, so an agent can identify which field uses the Animated GIF URL formatter.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ag_gallery")) {
    FieldStorageConfig::create(["field_name"=>"field_ag_gallery","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ag_gallery")) {
    FieldConfig::create(["field_name"=>"field_ag_gallery","entity_type"=>"node","bundle"=>"article","label"=>"AG Gallery"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ag_gallery", ["type"=>"animated_gif_image_url","label"=>"hidden","weight"=>51,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ag_gallery uses animated_gif_image_url on node.article.default"
