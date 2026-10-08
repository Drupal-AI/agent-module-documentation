#!/usr/bin/env bash
# Execution RESET: ensure address field field_addisp_task exists on Article, with its default
# view-display component using the core address_default formatter (NOT address_display_formatter),
# so verify FAILS until the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_addisp_task")) {
    FieldStorageConfig::create(["field_name"=>"field_addisp_task","entity_type"=>"node","type"=>"address"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_addisp_task")) {
    FieldConfig::create(["field_name"=>"field_addisp_task","entity_type"=>"node","bundle"=>"article","label"=>"Addisp Task"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_addisp_task", ["type"=>"address_default","label"=>"above","region"=>"content","weight"=>61,"settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_addisp_task present using core address_default formatter"
