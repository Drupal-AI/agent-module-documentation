#!/usr/bin/env bash
# Introspection SETUP: create string field field_ef on Article and set empty_fields handler=text
# with empty_text=EF_KNOWN_TEXT on its default display component. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ef")) {
    FieldStorageConfig::create(["field_name"=>"field_ef","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ef")) {
    FieldConfig::create(["field_name"=>"field_ef","entity_type"=>"node","bundle"=>"article","label"=>"EF"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ef", ["type"=>"string","region"=>"content","label"=>"above","settings"=>[],
    "third_party_settings"=>["empty_fields"=>["handler"=>"text","settings"=>["empty_text"=>"EF_KNOWN_TEXT"]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ef empty_fields handler=text empty_text=EF_KNOWN_TEXT"
