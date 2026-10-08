#!/usr/bin/env bash
# Execution RESET: attach a string field field_hdg_fmt to Article and set its default display
# to the plain string formatter (NOT heading_text), so verify FAILS until the agent switches it
# to the heading module's heading_text formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_hdg_fmt")) {
    FieldStorageConfig::create(["field_name"=>"field_hdg_fmt","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_hdg_fmt")) {
    FieldConfig::create(["field_name"=>"field_hdg_fmt","entity_type"=>"node","bundle"=>"article","label"=>"Fmt Title"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_hdg_fmt",["type"=>"string","settings"=>[],"label"=>"above","region"=>"content","weight"=>61])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_hdg_fmt displayed with plain string formatter"
