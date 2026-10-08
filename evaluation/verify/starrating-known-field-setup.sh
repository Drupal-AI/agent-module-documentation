#!/usr/bin/env bash
# Introspection SETUP: create a starrating field field_srt_known on Article with max_value=7 and
# display it with the icon formatter using icon_type=fire, fill_blank=1, so an agent can read
# back the max rating and icon type from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_srt_known")) {
    FieldStorageConfig::create(["field_name"=>"field_srt_known","entity_type"=>"node","type"=>"starrating"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_srt_known")) {
    FieldConfig::create(["field_name"=>"field_srt_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Rating","settings"=>["max_value"=>7]])->save();
  } else {
    $fc = FieldConfig::loadByName("node","article","field_srt_known"); $fc->setSetting("max_value",7); $fc->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_srt_known",["type"=>"starrating","settings"=>["icon_type"=>"fire","icon_color"=>2,"fill_blank"=>1],"weight"=>60,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_srt_known max_value=7, formatter icon_type=fire"
