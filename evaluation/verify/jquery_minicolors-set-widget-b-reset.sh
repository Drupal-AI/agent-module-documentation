#!/usr/bin/env bash
# Execution RESET: ensure string field field_jqmc_task2 exists on Article using string_textfield.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_jqmc_task2")) {
    FieldStorageConfig::create(["field_name" => "field_jqmc_task2", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_jqmc_task2")) {
    FieldConfig::create(["field_name" => "field_jqmc_task2", "entity_type" => "node", "bundle" => "article", "label" => "JQMC Task 2"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default")
    ->setComponent("field_jqmc_task2", ["type" => "string_textfield", "weight" => 53, "region" => "content"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_jqmc_task2 present with string_textfield widget"
