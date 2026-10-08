#!/usr/bin/env bash
# Execution RESET: ensure field_ctry_fmt exists on Article shown with the NAME formatter
# (country_default) so verify (which wants country_iso_code) FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ctry_fmt")) {
    FieldStorageConfig::create(["field_name"=>"field_ctry_fmt","entity_type"=>"node","type"=>"country"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ctry_fmt")) {
    FieldConfig::create(["field_name"=>"field_ctry_fmt","entity_type"=>"node","bundle"=>"article","label"=>"Formatter Country"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ctry_fmt", ["type"=>"country_default","label"=>"above","weight"=>50,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ctry_fmt shown with country_default (name) formatter"
