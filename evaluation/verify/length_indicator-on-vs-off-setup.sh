#!/usr/bin/env bash
# Introspection SETUP: two string fields on Article, field_li_on (indicator ON) and
# field_li_off (no length_indicator setting). Agent must say which hides.. which has it on.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_li_on","field_li_off"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"string"])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>$fn])->save();
    }
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_li_on", [
    "type" => "string_textfield", "weight" => 50, "region" => "content",
    "third_party_settings" => ["length_indicator" => [
      "indicator" => TRUE, "indicator_opt" => ["optimin"=>25,"optimax"=>45,"tolerance"=>5],
    ]],
  ]);
  $fd->setComponent("field_li_off", [
    "type" => "string_textfield", "weight" => 51, "region" => "content",
  ]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_li_on has length_indicator on; field_li_off does not"
