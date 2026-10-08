#!/usr/bin/env bash
# Execution RESET: ensure fivestar field field_fs_display exists on Article and its default
# view-display formatter is set to fivestar_percentage (NOT fivestar_rating), so the verify
# script FAILS until the agent switches the formatter to fivestar_rating. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fs_display")) {
    FieldStorageConfig::create([
      "field_name" => "field_fs_display", "entity_type" => "node",
      "type" => "fivestar", "settings" => ["vote_type" => "vote"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fs_display")) {
    FieldConfig::create([
      "field_name" => "field_fs_display", "entity_type" => "node", "bundle" => "article",
      "label" => "Display Rating",
    ])->save();
  }
  \Drupal::service("entity_display.repository")
    ->getViewDisplay("node", "article", "default")
    ->setComponent("field_fs_display", ["type" => "fivestar_percentage", "settings" => []])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fs_display present, formatter=fivestar_percentage"
