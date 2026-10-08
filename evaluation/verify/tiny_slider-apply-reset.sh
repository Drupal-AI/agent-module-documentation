#!/usr/bin/env bash
# Execution RESET: ensure image field field_ts_task exists on Article and force its default view
# display formatter to the plain core 'image' formatter (NOT tiny_slider), so verify FAILS until
# the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ts_task")) {
    FieldStorageConfig::create(["field_name" => "field_ts_task", "entity_type" => "node", "type" => "image", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ts_task")) {
    FieldConfig::create(["field_name" => "field_ts_task", "entity_type" => "node", "bundle" => "article", "label" => "Task Gallery"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ts_task", [
    "type" => "image", "label" => "hidden", "region" => "content", "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ts_task uses core image formatter (not tiny_slider)"
