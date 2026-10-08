#!/usr/bin/env bash
# Execution RESET: ensure a string field field_nm_task exists on Article with a formatter on
# the default view display and nomarkup FORCED OFF (enabled=false), so verify FAILS until the
# agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_nm_task")) {
    FieldStorageConfig::create(["field_name" => "field_nm_task", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_nm_task")) {
    FieldConfig::create(["field_name" => "field_nm_task", "entity_type" => "node", "bundle" => "article", "label" => "Task NoMarkup"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_nm_task", [
    "type" => "string", "weight" => 52, "region" => "content", "label" => "above",
    "third_party_settings" => ["nomarkup" => ["enabled" => FALSE, "separator" => "|", "referenced_entity" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_nm_task present with nomarkup.enabled=FALSE"
