#!/usr/bin/env bash
# Introspection SETUP (entity_browser_vertical): two entity_reference fields on Article, both
# using the Entity Browser widget; field_ebv_on uses the vertical display plugin, field_ebv_off
# uses the plain "label" display. Agent must say which one stacks vertically. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_ebv_on" => "entity_browser_vertical_label", "field_ebv_off" => "label"] as $fn => $disp) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name" => $fn, "entity_type" => "node",
        "type" => "entity_reference", "settings" => ["target_type" => "node"]])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create(["field_name" => $fn, "entity_type" => "node", "bundle" => "article",
        "label" => $fn, "settings" => ["handler" => "default", "handler_settings" => []]])->save();
    }
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
    $fd->setComponent($fn, ["type" => "entity_browser_entity_reference", "region" => "content",
      "weight" => 51, "settings" => ["entity_browser" => "", "field_widget_display" => $disp]])->save();
  }
' >/dev/null 2>&1 || true
echo "setup: field_ebv_on=vertical, field_ebv_off=label on node.article default form display"
exit 0
