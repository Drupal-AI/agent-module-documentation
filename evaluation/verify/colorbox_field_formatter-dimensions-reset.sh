#!/usr/bin/env bash
# Execution RESET: ensure field_cff_dim exists on Article displayed with colorbox_field_formatter
# at default dimensions (width 500, iframe off), so verify FAILS until the agent sets width=900 and
# enables iframe mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cff_dim")) {
    FieldStorageConfig::create(["field_name"=>"field_cff_dim","entity_type"=>"node","type"=>"string","cardinality"=>1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_cff_dim")) {
    FieldConfig::create(["field_name"=>"field_cff_dim","entity_type"=>"node","bundle"=>"article","label"=>"CFF Dim"])->save();
  }
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_cff_dim", [
    "type" => "colorbox_field_formatter",
    "settings" => ["style"=>"default","link_type"=>"content","width"=>"500","height"=>"500","iframe"=>0],
    "region" => "content", "weight" => 23,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_cff_dim uses colorbox_field_formatter width=500 iframe=0"
