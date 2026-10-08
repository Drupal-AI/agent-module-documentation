#!/usr/bin/env bash
# Execution RESET (daterange_compact formatter): ensure a daterange field field_dc_range exists
# on Article, displayed with the core daterange_default formatter (NOT Compact), so verify FAILS
# until the agent switches the display formatter to daterange_compact. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_dc_range")) {
    FieldStorageConfig::create(["field_name"=>"field_dc_range","entity_type"=>"node","type"=>"daterange","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_dc_range")) {
    FieldConfig::create(["field_name"=>"field_dc_range","entity_type"=>"node","bundle"=>"article","label"=>"DC Range"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_dc_range",["type"=>"daterange_default","label"=>"above","region"=>"content","weight"=>42])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_dc_range present, display formatter daterange_default"
