#!/usr/bin/env bash
# Execution RESET (entity_browser_vertical): ensure entity_reference field field_ebv_task exists
# on Article using the Entity Browser widget, with field_widget_display forced to the plain
# "label" display (NOT vertical) so verify FAILS until the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ebv_task")) {
    FieldStorageConfig::create(["field_name" => "field_ebv_task", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "node"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ebv_task")) {
    FieldConfig::create(["field_name" => "field_ebv_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Curated items",
      "settings" => ["handler" => "default", "handler_settings" => []]])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ebv_task", ["type" => "entity_browser_entity_reference",
    "region" => "content", "weight" => 52,
    "settings" => ["entity_browser" => "", "field_widget_display" => "label"]])->save();
' >/dev/null 2>&1 || true
echo "reset: field_ebv_task present, field_widget_display=label (not vertical)"
exit 0
