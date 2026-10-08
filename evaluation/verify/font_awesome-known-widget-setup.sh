#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fa_wknown")) {
    FieldStorageConfig::create(["field_name"=>"field_fa_wknown","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fa_wknown")) {
    FieldConfig::create(["field_name"=>"field_fa_wknown","entity_type"=>"node","bundle"=>"article","label"=>"Known Icon Widget"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_fa_wknown", ["type"=>"font_awesome_icon_picker_widget","weight"=>52,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_fa_wknown widget=font_awesome_icon_picker_widget"
