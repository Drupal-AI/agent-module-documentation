#!/usr/bin/env bash
# Execution RESET: ensure Article has a string field field_faip_task whose default form-display
# widget is the plain string_textfield (NOT the icon picker), so verify FAILS until the agent
# switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_faip_task")) {
    FieldStorageConfig::create(["field_name"=>"field_faip_task","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_faip_task")) {
    FieldConfig::create(["field_name"=>"field_faip_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Icon"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_faip_task",["type"=>"string_textfield","weight"=>50,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
echo "reset: field_faip_task uses string_textfield (not the icon picker)"
