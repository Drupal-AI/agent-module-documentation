#!/usr/bin/env bash
# Execution RESET: ensure text field field_oel_task exists on Article with a plain core 'string'
# formatter, so verify FAILS until the agent switches the view-display formatter to
# lazyload_oembed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_oel_task")) {
    FieldStorageConfig::create(["field_name"=>"field_oel_task","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_oel_task")) {
    FieldConfig::create(["field_name"=>"field_oel_task","entity_type"=>"node","bundle"=>"article","label"=>"OEL Task"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_oel_task", ["type"=>"string","label"=>"hidden","region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_oel_task uses core string formatter"
