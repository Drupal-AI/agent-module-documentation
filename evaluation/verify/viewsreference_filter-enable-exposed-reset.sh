#!/usr/bin/env bash
# Execution RESET: ensure a viewsreference field field_vrf_task exists on Article with
# exposed_filters NOT enabled (enabled_settings empty), so verify FAILS until the agent turns
# it on. Creates the field if missing. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_vrf_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_vrf_task", "entity_type" => "node",
      "type" => "viewsreference", "settings" => ["target_type" => "view"],
    ])->save();
  }
  if ($fc = FieldConfig::loadByName("node", "article", "field_vrf_task")) {
    $fc->setSetting("enabled_settings", [])->save();
  } else {
    FieldConfig::create([
      "field_name" => "field_vrf_task", "entity_type" => "node", "bundle" => "article",
      "label" => "Task View Ref", "settings" => ["enabled_settings" => []],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_vrf_task present, enabled_settings empty (exposed_filters OFF)"
