#!/usr/bin/env bash
# Execution RESET: ensure field_cmv_task exists on Article and its default view display uses
# the plain 'string' formatter (so verify FAILS until the agent switches to colorbox). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_cmv_task")) {
    FieldStorageConfig::create(["field_name"=>"field_cmv_task","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_cmv_task")) {
    FieldConfig::create(["field_name"=>"field_cmv_task","entity_type"=>"node","bundle"=>"article","label"=>"CMV Task Video"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_cmv_task", ["type"=>"string","label"=>"hidden","weight"=>52,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_cmv_task uses plain string formatter"
