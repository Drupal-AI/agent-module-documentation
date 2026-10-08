#!/usr/bin/env bash
# Introspection SETUP: create a multi-value string field field_nm_multi on Article with
# nomarkup enabled and a known non-default separator (";"), so an inspecting agent can read
# back the separator. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_nm_multi")) {
    FieldStorageConfig::create(["field_name" => "field_nm_multi", "entity_type" => "node", "type" => "string", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_nm_multi")) {
    FieldConfig::create(["field_name" => "field_nm_multi", "entity_type" => "node", "bundle" => "article", "label" => "Multi NoMarkup"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_nm_multi", [
    "type" => "string", "weight" => 51, "region" => "content", "label" => "hidden",
    "third_party_settings" => ["nomarkup" => ["enabled" => TRUE, "separator" => ";", "referenced_entity" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_nm_multi has nomarkup.enabled=true with separator ;"
