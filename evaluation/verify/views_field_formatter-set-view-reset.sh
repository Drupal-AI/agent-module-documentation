#!/usr/bin/env bash
# Execution RESET: ensure a string field field_vff_task exists on Article shown with the plain
# 'string' formatter (NOT views_field_formatter), so verify FAILS until the agent switches it
# to the View formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_vff_task")) {
    FieldStorageConfig::create(["field_name" => "field_vff_task", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vff_task")) {
    FieldConfig::create(["field_name" => "field_vff_task", "entity_type" => "node", "bundle" => "article", "label" => "Task VFF"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_vff_task", ["type" => "string", "weight" => 62, "region" => "content", "label" => "above"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_vff_task present with plain string formatter"
