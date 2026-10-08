#!/usr/bin/env bash
# Execution RESET: ensure Article has a metatag field field_maw_task whose default form-display
# widget is the CORE metatag_firehose (NOT async), so verify fails until the agent switches it to
# metatag_async_widget_firehose. Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_maw_task")) { FieldStorageConfig::create(["field_name"=>"field_maw_task","entity_type"=>"node","type"=>"metatag"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_maw_task")) { FieldConfig::create(["field_name"=>"field_maw_task","entity_type"=>"node","bundle"=>"article","label"=>"MAW Task"])->save(); }
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_maw_task",["type"=>"metatag_firehose","weight"=>50,"region"=>"content","settings"=>["sidebar"=>true]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_maw_task widget=metatag_firehose (not async)"
