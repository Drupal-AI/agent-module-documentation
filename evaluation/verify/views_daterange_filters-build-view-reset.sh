#!/usr/bin/env bash
# Execution RESET: ensure daterange field field_vdf_task exists on Article, and delete any
# view named vdf_build so the agent must build it. Verify FAILS on this empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if (!FieldStorageConfig::loadByName("node", "field_vdf_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_vdf_task", "entity_type" => "node",
      "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vdf_task")) {
    FieldConfig::create([
      "field_name" => "field_vdf_task", "entity_type" => "node",
      "bundle" => "article", "label" => "VDF Task Window",
    ])->save();
  }
  if ($v = View::load("vdf_build")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_vdf_task present; view vdf_build absent"
