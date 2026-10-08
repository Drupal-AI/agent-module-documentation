#!/usr/bin/env bash
# Introspection SETUP: create entity_reference field field_erv_known on Article and set its
# default form-display widget to erviews_options_select, so an agent can read back which widget
# it uses. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_erv_known")) {
    FieldStorageConfig::create(["field_name"=>"field_erv_known","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_erv_known")) {
    FieldConfig::create(["field_name"=>"field_erv_known","entity_type"=>"node","bundle"=>"article","label"=>"ERV Known"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default")
    ->setComponent("field_erv_known", ["type"=>"erviews_options_select","region"=>"content","settings"=>["empty_value"=>"- None -"],"weight"=>60])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_erv_known uses widget erviews_options_select"
