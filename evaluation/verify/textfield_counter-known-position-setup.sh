#!/usr/bin/env bash
# Introspection SETUP: field_tfc_pos (string_long) using string_textarea_with_counter with the
# counter positioned BEFORE the field and maxlength 200.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_tfc_pos")) {
    FieldStorageConfig::create(["field_name"=>"field_tfc_pos","entity_type"=>"node","type"=>"string_long"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_tfc_pos")) {
    FieldConfig::create(["field_name"=>"field_tfc_pos","entity_type"=>"node","bundle"=>"article","label"=>"Positioned Counter"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_tfc_pos", ["type"=>"string_textarea_with_counter","weight"=>61,"region"=>"content","settings"=>["maxlength"=>200,"counter_position"=>"before"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_tfc_pos uses string_textarea_with_counter counter_position=before maxlength=200"
