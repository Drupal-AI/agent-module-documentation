#!/usr/bin/env bash
# Execution RESET: ensure datetime field field_ft_task exists on Article and its default
# view display uses the CORE datetime_default formatter (NOT a field_timer one), so verify
# FAILS until the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ft_task")) {
    FieldStorageConfig::create(["field_name"=>"field_ft_task","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ft_task")) {
    FieldConfig::create(["field_name"=>"field_ft_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Timer"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ft_task", ["type"=>"datetime_default","label"=>"hidden","settings"=>[],"weight"=>51,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ft_task present with core datetime_default formatter"
