#!/usr/bin/env bash
# Execution RESET: create starrating field field_srt_fmt on Article displayed with the default
# ICON formatter (type=starrating). verify FAILS until the agent switches it to the
# starrating_value_rating ("8/10") formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_srt_fmt")) {
    FieldStorageConfig::create(["field_name"=>"field_srt_fmt","entity_type"=>"node","type"=>"starrating"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_srt_fmt")) {
    FieldConfig::create(["field_name"=>"field_srt_fmt","entity_type"=>"node","bundle"=>"article","label"=>"Format Rating","settings"=>["max_value"=>10]])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_srt_fmt",["type"=>"starrating","settings"=>["icon_type"=>"star","icon_color"=>1,"fill_blank"=>0],"weight"=>61,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_srt_fmt displayed with icon formatter (starrating)"
