#!/usr/bin/env bash
# Execution RESET: ensure a multi-value string field field_nm_sep exists on Article with a
# formatter on the default view display, nomarkup OFF and the default separator, so verify
# FAILS until the agent enables nomarkup AND sets the separator to " / ". Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_nm_sep")) {
    FieldStorageConfig::create(["field_name" => "field_nm_sep", "entity_type" => "node", "type" => "string", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_nm_sep")) {
    FieldConfig::create(["field_name" => "field_nm_sep", "entity_type" => "node", "bundle" => "article", "label" => "Sep NoMarkup"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_nm_sep", [
    "type" => "string", "weight" => 53, "region" => "content", "label" => "above",
    "third_party_settings" => ["nomarkup" => ["enabled" => FALSE, "separator" => "|", "referenced_entity" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_nm_sep present with nomarkup OFF, separator |"
