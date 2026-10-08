#!/usr/bin/env bash
# Execution RESET: ensure Article has field_maw_task2 using the async widget with sidebar=FALSE,
# so verify (which needs sidebar TRUE) fails until the agent enables the sidebar setting.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_maw_task2")) { FieldStorageConfig::create(["field_name"=>"field_maw_task2","entity_type"=>"node","type"=>"metatag"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_maw_task2")) { FieldConfig::create(["field_name"=>"field_maw_task2","entity_type"=>"node","bundle"=>"article","label"=>"MAW Task2"])->save(); }
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_maw_task2",["type"=>"metatag_async_widget_firehose","weight"=>50,"region"=>"content","settings"=>["sidebar"=>false]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_maw_task2 async widget, sidebar=FALSE"
