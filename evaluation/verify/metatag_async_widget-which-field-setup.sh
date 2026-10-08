#!/usr/bin/env bash
# Introspection SETUP: add two metatag fields to Article - field_maw_async (async widget) and
# field_maw_std (default metatag_firehose widget) - so an agent can tell which uses the async
# widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_maw_async","field_maw_std"] as $fn) {
    if (!FieldStorageConfig::loadByName("node",$fn)) { FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"metatag"])->save(); }
    if (!FieldConfig::loadByName("node","article",$fn)) { FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>strtoupper($fn)])->save(); }
  }
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_maw_async",["type"=>"metatag_async_widget_firehose","weight"=>50,"region"=>"content","settings"=>["sidebar"=>true]]);
  $fd->setComponent("field_maw_std",["type"=>"metatag_firehose","weight"=>51,"region"=>"content","settings"=>["sidebar"=>true]]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_maw_async=async widget, field_maw_std=metatag_firehose"
