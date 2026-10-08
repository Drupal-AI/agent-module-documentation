#!/usr/bin/env bash
# Execution RESET: create a string field field_cjs_lbl on Article with a clipboard_button
# formatter whose label is the default 'Click to copy', so verify FAILS until the agent changes
# the label to 'Copy value'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cjs_lbl")) {
    FieldStorageConfig::create(["field_name" => "field_cjs_lbl", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_cjs_lbl")) {
    FieldConfig::create(["field_name" => "field_cjs_lbl", "entity_type" => "node", "bundle" => "article", "label" => "Label Field"])->save();
  }
  \Drupal::service("entity_display.repository")
    ->getViewDisplay("node", "article", "default")
    ->setComponent("field_cjs_lbl", ["type" => "clipboard_button", "settings" => ["label" => "Click to copy", "alert_style" => "tooltip", "alert_text" => "Copied!"]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_cjs_lbl clipboard_button label='Click to copy'"
