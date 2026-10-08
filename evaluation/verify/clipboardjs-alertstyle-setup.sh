#!/usr/bin/env bash
# Introspection SETUP: create a string field field_cjs_style on Article with a clipboard_textarea
# formatter whose alert_style is 'none' (no confirmation), so an inspecting agent can read it
# back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cjs_style")) {
    FieldStorageConfig::create(["field_name" => "field_cjs_style", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_cjs_style")) {
    FieldConfig::create(["field_name" => "field_cjs_style", "entity_type" => "node", "bundle" => "article", "label" => "Style Field"])->save();
  }
  \Drupal::service("entity_display.repository")
    ->getViewDisplay("node", "article", "default")
    ->setComponent("field_cjs_style", ["type" => "clipboard_textarea", "settings" => ["label" => "Click to copy", "alert_style" => "none", "alert_text" => "Copied!"]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_cjs_style formatter clipboard_textarea (alert_style=none)"
