#!/usr/bin/env bash
# Introspection SETUP: create a string field field_nm_known on Article and enable nomarkup
# "Remove field markup" on its formatter in the default view display, so an inspecting agent
# can read back which field renders without markup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_nm_known")) {
    FieldStorageConfig::create(["field_name" => "field_nm_known", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_nm_known")) {
    FieldConfig::create(["field_name" => "field_nm_known", "entity_type" => "node", "bundle" => "article", "label" => "Known NoMarkup"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_nm_known", [
    "type" => "string", "weight" => 50, "region" => "content", "label" => "hidden",
    "third_party_settings" => ["nomarkup" => ["enabled" => TRUE, "separator" => "|", "referenced_entity" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_nm_known has nomarkup.enabled=true on default view display"
