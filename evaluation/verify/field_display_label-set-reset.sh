#!/usr/bin/env bash
# Execution RESET: ensure field_fdl_task exists on Article WITHOUT a field_display_label display
# label, so verify FAILS until the agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fdl_task")) {
    FieldStorageConfig::create(["field_name" => "field_fdl_task", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fdl_task")) {
    FieldConfig::create(["field_name" => "field_fdl_task", "entity_type" => "node", "bundle" => "article", "label" => "Task Field"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_fdl_task");
  $fc->unsetThirdPartySetting("field_display_label", "display_label")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fdl_task present, no display label"
