#!/usr/bin/env bash
# Introspection SETUP: add image field field_ag_shown to Article and set its default view-display
# formatter to animated_gif_image_url, so an agent can read the formatter back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ag_shown")) {
    FieldStorageConfig::create(["field_name"=>"field_ag_shown","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ag_shown")) {
    FieldConfig::create(["field_name"=>"field_ag_shown","entity_type"=>"node","bundle"=>"article","label"=>"AG Shown"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ag_shown", ["type"=>"animated_gif_image_url","label"=>"hidden","weight"=>50,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ag_shown on node.article.default uses animated_gif_image_url"
