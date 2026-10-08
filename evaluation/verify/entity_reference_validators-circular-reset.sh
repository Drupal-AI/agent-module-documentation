#!/usr/bin/env bash
# Execution RESET: ensure entity_reference field field_erv_task exists on Article (targeting
# nodes) with circular_reference FORCED OFF, so verify FAILS until the agent enables it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_erv_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_erv_task", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "node"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_erv_task");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_erv_task", "entity_type" => "node", "bundle" => "article",
      "label" => "ERV Task", "settings" => ["handler" => "default:node", "handler_settings" => []],
    ]);
  }
  $fc->setThirdPartySetting("entity_reference_validators", "circular_reference", FALSE);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_erv_task present with circular_reference=FALSE"
