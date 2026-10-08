#!/usr/bin/env bash
# Execution RESET: ensure field_ef_pop (text) exists on Article shown with a PLAIN 'string'
# formatter, so verify FAILS until the agent switches it to the Editable field formatter with
# popup behaviour. Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ef_pop")) {
    FieldStorageConfig::create(["field_name"=>"field_ef_pop","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ef_pop")) {
    FieldConfig::create(["field_name"=>"field_ef_pop","entity_type"=>"node","bundle"=>"article","label"=>"Popup Note"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ef_pop", ["type" => "string", "label" => "above", "weight" => 83, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ef_pop uses plain string formatter"
