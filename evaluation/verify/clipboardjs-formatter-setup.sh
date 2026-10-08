#!/usr/bin/env bash
# Introspection SETUP: create a string field field_cjs_known on Article and set its default
# view-display formatter to clipboard_button with a distinctive alert style, so an inspecting
# agent can read the formatter back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cjs_known")) {
    FieldStorageConfig::create(["field_name" => "field_cjs_known", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_cjs_known")) {
    FieldConfig::create(["field_name" => "field_cjs_known", "entity_type" => "node", "bundle" => "article", "label" => "Known Code"])->save();
  }
  \Drupal::service("entity_display.repository")
    ->getViewDisplay("node", "article", "default")
    ->setComponent("field_cjs_known", ["type" => "clipboard_button", "settings" => ["label" => "Copy SKU", "alert_style" => "alert", "alert_text" => "Copied!"]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_cjs_known formatter clipboard_button (alert_style=alert)"
