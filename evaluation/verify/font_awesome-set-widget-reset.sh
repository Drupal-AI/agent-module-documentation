#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fa_wtask")) {
    FieldStorageConfig::create(["field_name"=>"field_fa_wtask","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fa_wtask")) {
    FieldConfig::create(["field_name"=>"field_fa_wtask","entity_type"=>"node","bundle"=>"article","label"=>"Task Icon Widget"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_fa_wtask", ["type"=>"string_textfield","weight"=>53,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fa_wtask uses plain string_textfield widget"
