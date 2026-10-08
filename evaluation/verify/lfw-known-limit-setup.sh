#!/usr/bin/env bash
# Introspection SETUP: create unlimited field field_lfw_known on Article and cap it at 4
# via limited_field_widgets on the default form display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_lfw_known")) {
    FieldStorageConfig::create(["field_name"=>"field_lfw_known","entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_lfw_known")) {
    FieldConfig::create(["field_name"=>"field_lfw_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Limited"])->save();
  }
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_lfw_known",["type"=>"string_textfield","weight"=>50,"region"=>"content","third_party_settings"=>["limited_field_widgets"=>["limit_values"=>4]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_lfw_known limit_values=4"
