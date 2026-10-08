#!/usr/bin/env bash
# Introspection SETUP: add a metatag field field_maw_meta to Article and set its default
# form-display widget to the async widget metatag_async_widget_firehose. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_maw_meta")) { FieldStorageConfig::create(["field_name"=>"field_maw_meta","entity_type"=>"node","type"=>"metatag"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_maw_meta")) { FieldConfig::create(["field_name"=>"field_maw_meta","entity_type"=>"node","bundle"=>"article","label"=>"MAW Meta"])->save(); }
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_maw_meta",["type"=>"metatag_async_widget_firehose","weight"=>50,"region"=>"content","settings"=>["sidebar"=>true]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_maw_meta widget=metatag_async_widget_firehose"
