#!/usr/bin/env bash
# Execution RESET: ensure a string field field_tfc_limit on Article uses
# string_textfield_with_counter but with maxlength=0 (counter disabled), so verify FAILS until
# the agent sets a 100-character limit.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_tfc_limit")) {
    FieldStorageConfig::create(["field_name"=>"field_tfc_limit","entity_type"=>"node","type"=>"string","settings"=>["max_length"=>255]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_tfc_limit")) {
    FieldConfig::create(["field_name"=>"field_tfc_limit","entity_type"=>"node","bundle"=>"article","label"=>"Limited Headline"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_tfc_limit", ["type"=>"string_textfield_with_counter","weight"=>63,"region"=>"content","settings"=>["maxlength"=>0,"use_field_maxlength"=>0]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_tfc_limit uses string_textfield_with_counter maxlength=0 (disabled)"
