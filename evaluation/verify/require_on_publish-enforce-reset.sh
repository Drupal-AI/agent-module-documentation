#!/usr/bin/env bash
# Execution RESET: ensure a string field field_rop_enf exists on Article with require_on_publish
# OFF. In this state a published Article with the field empty validates cleanly, so verify FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_rop_enf")) {
    FieldStorageConfig::create(["field_name" => "field_rop_enf", "entity_type" => "node", "type" => "string"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_rop_enf") ?: FieldConfig::create(["field_name" => "field_rop_enf", "entity_type" => "node", "bundle" => "article", "label" => "Enforce ROP"]);
  $fc->unsetThirdPartySetting("require_on_publish", "require_on_publish");
  $fc->save();
' >/dev/null 2>&1
echo "reset: field_rop_enf present, require_on_publish OFF (no publish enforcement)"
