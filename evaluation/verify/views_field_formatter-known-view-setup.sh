#!/usr/bin/env bash
# Introspection SETUP: create a string field field_vff_known on Article and set its formatter
# on the default view display to the 'View' formatter (views_field_formatter) rendering the
# frontpage view, so an inspecting agent can read back which view is used. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_vff_known")) {
    FieldStorageConfig::create(["field_name" => "field_vff_known", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vff_known")) {
    FieldConfig::create(["field_name" => "field_vff_known", "entity_type" => "node", "bundle" => "article", "label" => "Known VFF"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_vff_known", [
    "type" => "views_field_formatter", "weight" => 60, "region" => "content", "label" => "hidden",
    "settings" => ["view" => "frontpage::page_1", "arguments" => [], "hide_empty" => TRUE, "multiple" => FALSE, "implode_character" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_vff_known uses views_field_formatter with view frontpage::page_1"
