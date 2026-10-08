#!/usr/bin/env bash
# Execution RESET: ensure Article has a string field field_faip_display whose default
# view-display formatter is the plain string formatter (NOT the icon picker), so verify FAILS
# until the agent switches it to the icon picker at fa-2x. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_faip_display")) {
    FieldStorageConfig::create(["field_name"=>"field_faip_display","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_faip_display")) {
    FieldConfig::create(["field_name"=>"field_faip_display","entity_type"=>"node","bundle"=>"article","label"=>"Display Icon"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_faip_display",["type"=>"string","weight"=>50,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
echo "reset: field_faip_display uses the plain string formatter"
