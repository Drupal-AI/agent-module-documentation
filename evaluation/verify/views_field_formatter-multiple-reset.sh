#!/usr/bin/env bash
# Execution RESET: ensure a multi-value string field field_vff_mult exists on Article using the
# 'View' formatter but with multiple=false and an empty implode character, so verify FAILS
# until the agent enables multiple mode and sets the implode character. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_vff_mult")) {
    FieldStorageConfig::create(["field_name" => "field_vff_mult", "entity_type" => "node", "type" => "string", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vff_mult")) {
    FieldConfig::create(["field_name" => "field_vff_mult", "entity_type" => "node", "bundle" => "article", "label" => "Mult VFF"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_vff_mult", [
    "type" => "views_field_formatter", "weight" => 63, "region" => "content", "label" => "hidden",
    "settings" => ["view" => "frontpage::page_1", "arguments" => [], "hide_empty" => FALSE, "multiple" => FALSE, "implode_character" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_vff_mult views_field_formatter multiple=FALSE implode empty"
