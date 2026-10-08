#!/usr/bin/env bash
# Execution RESET: link field on Article shown with the plain core 'link' formatter (no class),
# so verify FAILS until the agent switches it to link_class with the class. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ecf_lnk")) { FieldStorageConfig::create(["field_name"=>"field_ecf_lnk","entity_type"=>"node","type"=>"link"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ecf_lnk")) { FieldConfig::create(["field_name"=>"field_ecf_lnk","entity_type"=>"node","bundle"=>"article","label"=>"ECF Lnk"])->save(); }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_ecf_lnk", ["type"=>"link","label"=>"hidden","weight"=>52,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
echo "reset: field_ecf_lnk uses plain link formatter"
