#!/usr/bin/env bash
# Execution RESET: ensure string field field_jqmc_task exists on Article using the core
# 'string_textfield' widget (NOT minicolors), so verify FAILS until the agent switches it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_jqmc_task")) {
    FieldStorageConfig::create(["field_name" => "field_jqmc_task", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_jqmc_task")) {
    FieldConfig::create(["field_name" => "field_jqmc_task", "entity_type" => "node", "bundle" => "article", "label" => "JQMC Task"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default")
    ->setComponent("field_jqmc_task", ["type" => "string_textfield", "weight" => 52, "region" => "content"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_jqmc_task present with string_textfield widget"
