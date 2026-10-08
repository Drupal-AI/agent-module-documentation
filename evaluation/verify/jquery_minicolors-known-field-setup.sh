#!/usr/bin/env bash
# Introspection SETUP: create string field field_jqmc_known on Article using jquery_minicolors_widget,
# so an agent can read back which field uses it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_jqmc_known")) {
    FieldStorageConfig::create(["field_name" => "field_jqmc_known", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_jqmc_known")) {
    FieldConfig::create(["field_name" => "field_jqmc_known", "entity_type" => "node", "bundle" => "article", "label" => "JQMC Known"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default")
    ->setComponent("field_jqmc_known", ["type" => "jquery_minicolors_widget", "weight" => 50, "region" => "content"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_jqmc_known uses jquery_minicolors_widget"
