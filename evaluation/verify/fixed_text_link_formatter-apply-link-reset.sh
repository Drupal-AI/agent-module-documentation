#!/usr/bin/env bash
# Execution RESET: ensure a link field field_ftlf_task exists on Article displayed with the
# CORE 'link' formatter (NOT fixed_text_link), so verify FAILS until the agent switches it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ftlf_task")) {
    FieldStorageConfig::create(["field_name"=>"field_ftlf_task","entity_type"=>"node","type"=>"link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ftlf_task")) {
    FieldConfig::create(["field_name"=>"field_ftlf_task","entity_type"=>"node","bundle"=>"article","label"=>"FTLF Task"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ftlf_task", [
    "type"=>"link","label"=>"hidden","weight"=>52,"region"=>"content","settings"=>[],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ftlf_task uses core link formatter"
