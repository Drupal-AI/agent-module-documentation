#!/usr/bin/env bash
# Execution RESET: ensure a plain string field field_ff_str exists on Article, with its
# DEFAULT view-display component using the core 'string' formatter (NOT field_link), so verify
# FAILS until the agent switches it to field_formatter's "Field linker" (field_link).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ff_str")) {
    FieldStorageConfig::create(["field_name"=>"field_ff_str","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ff_str")) {
    FieldConfig::create(["field_name"=>"field_ff_str","entity_type"=>"node","bundle"=>"article","label"=>"FF String"])->save();
  }
  $vd=\Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ff_str", ["type"=>"string","label"=>"above","region"=>"content","weight"=>62,"settings"=>["link_to_entity"=>FALSE]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ff_str uses core string formatter"
