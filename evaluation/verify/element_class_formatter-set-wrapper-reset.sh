#!/usr/bin/env bash
# Execution RESET: string field on Article shown with the plain core 'string' formatter, so verify
# FAILS until the agent switches it to wrapper_class with a class. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ecf_str")) { FieldStorageConfig::create(["field_name"=>"field_ecf_str","entity_type"=>"node","type"=>"string"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ecf_str")) { FieldConfig::create(["field_name"=>"field_ecf_str","entity_type"=>"node","bundle"=>"article","label"=>"ECF Str"])->save(); }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_ecf_str", ["type"=>"string","label"=>"hidden","weight"=>53,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
echo "reset: field_ecf_str uses plain string formatter"
