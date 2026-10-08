#!/usr/bin/env bash
# Execution RESET: ensure interval field field_interval_limit exists on Article with its
# interval_default widget offering ALL periods (allowed_periods = []), so verify FAILS until
# the agent restricts it to day + week. Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_interval_limit")) {
    FieldStorageConfig::create([
      "field_name" => "field_interval_limit", "entity_type" => "node", "type" => "interval",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_interval_limit")) {
    FieldConfig::create([
      "field_name" => "field_interval_limit", "entity_type" => "node",
      "bundle" => "article", "label" => "Limited Duration",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_interval_limit", [
    "type" => "interval_default", "weight" => 50, "region" => "content",
    "settings" => ["allowed_periods" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_interval_limit present, allowed_periods = [] (all periods)"
