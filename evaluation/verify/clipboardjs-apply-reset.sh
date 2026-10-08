#!/usr/bin/env bash
# Execution RESET: create a string field field_cjs_task on Article and force its default
# view-display formatter to the plain core 'string' formatter, so verify FAILS until the agent
# switches it to a Clipboard.js formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cjs_task")) {
    FieldStorageConfig::create(["field_name" => "field_cjs_task", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_cjs_task")) {
    FieldConfig::create(["field_name" => "field_cjs_task", "entity_type" => "node", "bundle" => "article", "label" => "Task Code"])->save();
  }
  \Drupal::service("entity_display.repository")
    ->getViewDisplay("node", "article", "default")
    ->setComponent("field_cjs_task", ["type" => "string", "settings" => []])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_cjs_task uses the plain string formatter"
