#!/usr/bin/env bash
# Execution RESET (entity_browser_vertical, layman variant): entity_reference field
# field_ebv_gallery on Article using the Entity Browser widget with field_widget_display="label"
# (horizontal). Verify FAILS until switched to the vertical display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ebv_gallery")) {
    FieldStorageConfig::create(["field_name" => "field_ebv_gallery", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "node"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ebv_gallery")) {
    FieldConfig::create(["field_name" => "field_ebv_gallery", "entity_type" => "node",
      "bundle" => "article", "label" => "Gallery items",
      "settings" => ["handler" => "default", "handler_settings" => []]])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ebv_gallery", ["type" => "entity_browser_entity_reference",
    "region" => "content", "weight" => 53,
    "settings" => ["entity_browser" => "", "field_widget_display" => "label"]])->save();
' >/dev/null 2>&1 || true
echo "reset: field_ebv_gallery present, field_widget_display=label (not vertical)"
exit 0
