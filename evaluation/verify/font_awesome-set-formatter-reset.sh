#!/usr/bin/env bash
# Execution RESET: ensure a string field field_fa_task exists on Article with a plain 'string'
# formatter (NOT font_awesome_icon), so verify FAILS until the agent switches it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fa_task")) {
    FieldStorageConfig::create(["field_name"=>"field_fa_task","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fa_task")) {
    FieldConfig::create(["field_name"=>"field_fa_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Icon"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fa_task", ["type"=>"string","weight"=>51,"region"=>"content","settings"=>[],"label"=>"above"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fa_task present with plain string formatter"
