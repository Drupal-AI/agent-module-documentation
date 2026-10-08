#!/usr/bin/env bash
# Introspection SETUP: attach a string field (field_hdg_sub) to Article and set its default
# display to the heading module's heading_text formatter at size h4, so an agent can read the
# configured heading size. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_hdg_sub")) {
    FieldStorageConfig::create(["field_name"=>"field_hdg_sub","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_hdg_sub")) {
    FieldConfig::create(["field_name"=>"field_hdg_sub","entity_type"=>"node","bundle"=>"article","label"=>"Subtitle"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_hdg_sub",["type"=>"heading_text","settings"=>["size"=>"h4"],"label"=>"hidden","region"=>"content","weight"=>60])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_hdg_sub displayed with heading_text formatter at size h4"
