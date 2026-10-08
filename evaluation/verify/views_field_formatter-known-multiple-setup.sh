#!/usr/bin/env bash
# Introspection SETUP: create a multi-value string field field_vff_multi on Article with the
# 'View' formatter configured multiple=true and a known implode character (", "), so an
# inspecting agent can read those back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_vff_multi")) {
    FieldStorageConfig::create(["field_name" => "field_vff_multi", "entity_type" => "node", "type" => "string", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vff_multi")) {
    FieldConfig::create(["field_name" => "field_vff_multi", "entity_type" => "node", "bundle" => "article", "label" => "Multi VFF"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_vff_multi", [
    "type" => "views_field_formatter", "weight" => 61, "region" => "content", "label" => "hidden",
    "settings" => ["view" => "frontpage::page_1", "arguments" => [], "hide_empty" => FALSE, "multiple" => TRUE, "implode_character" => ", "],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_vff_multi views_field_formatter multiple=true implode_character=\", \""
