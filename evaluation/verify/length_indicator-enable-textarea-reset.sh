#!/usr/bin/env bash
# Execution RESET: ensure field_li_area (string_long, string_textarea) exists on Article with
# length_indicator OFF, so verify FAILS until the agent enables it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_li_area")) {
    FieldStorageConfig::create(["field_name"=>"field_li_area","entity_type"=>"node","type"=>"string_long"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_li_area")) {
    FieldConfig::create(["field_name"=>"field_li_area","entity_type"=>"node","bundle"=>"article","label"=>"Task Summary"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_li_area", [
    "type" => "string_textarea", "weight" => 51, "region" => "content",
    "third_party_settings" => ["length_indicator" => ["indicator" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_li_area present with length_indicator.indicator=FALSE"
