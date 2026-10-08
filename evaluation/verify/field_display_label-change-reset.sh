#!/usr/bin/env bash
# Execution RESET: ensure field_fdl_edit exists on Article WITH display label 'Old Label' so verify
# (which wants 'Customer Name') FAILS until the agent changes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fdl_edit")) {
    FieldStorageConfig::create(["field_name" => "field_fdl_edit", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fdl_edit")) {
    FieldConfig::create(["field_name" => "field_fdl_edit", "entity_type" => "node", "bundle" => "article", "label" => "Edit Field"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_fdl_edit");
  $fc->setThirdPartySetting("field_display_label", "display_label", "Old Label")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fdl_edit display_label=Old Label"
