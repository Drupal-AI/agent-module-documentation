#!/usr/bin/env bash
# Execution RESET: create a file field on Article displayed with the core file_default formatter,
# so verify fails until the agent switches it to file_download_link. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fdl_task")) {
    FieldStorageConfig::create(["field_name" => "field_fdl_task", "entity_type" => "node", "type" => "file"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fdl_task")) {
    FieldConfig::create(["field_name" => "field_fdl_task", "entity_type" => "node", "bundle" => "article", "label" => "FDL Task File"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fdl_task", ["type" => "file_default", "label" => "above", "weight" => 50, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_fdl_task uses core file_default formatter"
