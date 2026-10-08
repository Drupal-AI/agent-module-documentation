#!/usr/bin/env bash
# Execution RESET: ensure a long-text field field_bf_task exists on Article with NO
# better_formats allowed-formats restriction, so verify FAILS until the agent adds one.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_bf_task")) {
    FieldStorageConfig::create(["field_name" => "field_bf_task", "entity_type" => "node", "type" => "text_long"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_bf_task");
  if (!$fc) {
    $fc = FieldConfig::create(["field_name" => "field_bf_task", "entity_type" => "node", "bundle" => "article", "label" => "BF Task Text"]);
  }
  $fc->unsetThirdPartySetting("better_formats", "allowed_formats_toggle");
  $fc->unsetThirdPartySetting("better_formats", "allowed_formats");
  $fc->save();
' >/dev/null 2>&1
echo "reset: field_bf_task present with no better_formats restriction"
