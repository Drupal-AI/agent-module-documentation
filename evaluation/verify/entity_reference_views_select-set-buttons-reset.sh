#!/usr/bin/env bash
# Execution RESET: ensure entity_reference field field_erv_btask exists on Article with a plain
# core widget (entity_reference_autocomplete), so verify FAILS until the agent switches it to
# erviews_options_buttons. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_erv_btask")) {
    FieldStorageConfig::create(["field_name"=>"field_erv_btask","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_erv_btask")) {
    FieldConfig::create(["field_name"=>"field_erv_btask","entity_type"=>"node","bundle"=>"article","label"=>"ERV BTask"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default")
    ->setComponent("field_erv_btask", ["type"=>"entity_reference_autocomplete","region"=>"content","weight"=>63])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_erv_btask uses entity_reference_autocomplete"
