#!/usr/bin/env bash
# Execution RESET: ensure a string field field_rop_task exists on Article with require_on_publish
# OFF, so verify FAILS until the agent enables it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_rop_task")) {
    FieldStorageConfig::create(["field_name" => "field_rop_task", "entity_type" => "node", "type" => "string"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_rop_task") ?: FieldConfig::create(["field_name" => "field_rop_task", "entity_type" => "node", "bundle" => "article", "label" => "Task ROP"]);
  $fc->unsetThirdPartySetting("require_on_publish", "require_on_publish");
  $fc->unsetThirdPartySetting("require_on_publish", "warn_on_empty");
  $fc->save();
' >/dev/null 2>&1
echo "reset: field_rop_task present, require_on_publish OFF"
