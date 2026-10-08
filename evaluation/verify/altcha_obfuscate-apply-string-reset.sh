#!/usr/bin/env bash
# hard RESET (altcha_obfuscate): ensure string field field_aobf_task exists on Article displayed with
# the plain 'string' formatter so verify FAILS until obfuscated. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_aobf_task")) {
    FieldStorageConfig::create(["field_name" => "field_aobf_task", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_aobf_task")) {
    FieldConfig::create(["field_name" => "field_aobf_task", "entity_type" => "node", "bundle" => "article", "label" => "AOBF Task"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_aobf_task", ["type" => "string", "label" => "above", "weight" => 51])->save();
' >/dev/null 2>&1
echo "reset: field_aobf_task displayed with plain string formatter"
