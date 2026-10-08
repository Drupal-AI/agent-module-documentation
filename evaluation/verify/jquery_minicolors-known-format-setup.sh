#!/usr/bin/env bash
# Introspection SETUP: create string field field_jqmc_fmt on Article using jquery_minicolors_widget
# with format=rgb, so an agent can read back the format setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_jqmc_fmt")) {
    FieldStorageConfig::create(["field_name" => "field_jqmc_fmt", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_jqmc_fmt")) {
    FieldConfig::create(["field_name" => "field_jqmc_fmt", "entity_type" => "node", "bundle" => "article", "label" => "JQMC Fmt"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default")
    ->setComponent("field_jqmc_fmt", [
      "type" => "jquery_minicolors_widget", "weight" => 51, "region" => "content",
      "settings" => ["control" => "wheel", "format" => "rgb"],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_jqmc_fmt jquery_minicolors_widget format=rgb"
