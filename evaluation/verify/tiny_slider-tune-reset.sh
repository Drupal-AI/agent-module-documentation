#!/usr/bin/env bash
# Execution RESET: ensure image field field_ts_tune exists on Article using tiny_slider formatter
# with items=1 and autoplay OFF, so verify (wants items=4 AND autoplay ON) FAILS until the agent
# reconfigures it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ts_tune")) {
    FieldStorageConfig::create(["field_name" => "field_ts_tune", "entity_type" => "node", "type" => "image", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ts_tune")) {
    FieldConfig::create(["field_name" => "field_ts_tune", "entity_type" => "node", "bundle" => "article", "label" => "Tune Gallery"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ts_tune", [
    "type" => "tiny_slider_field_formatter", "label" => "hidden", "region" => "content",
    "settings" => ["items" => 1, "autoplay" => FALSE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ts_tune tiny_slider items=1 autoplay=FALSE"
