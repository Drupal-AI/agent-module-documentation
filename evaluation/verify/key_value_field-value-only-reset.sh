#!/usr/bin/env bash
# Execution RESET: create a key_value field field_kvf_disp on Article and force its formatter
# on the default view display to value_only=FALSE, so verify FAILS until the agent flips it to
# value_only=TRUE. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_kvf_disp")) {
    FieldStorageConfig::create([
      "field_name" => "field_kvf_disp", "entity_type" => "node", "type" => "key_value",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_kvf_disp")) {
    FieldConfig::create([
      "field_name" => "field_kvf_disp", "entity_type" => "node",
      "bundle" => "article", "label" => "Display Spec",
    ])->save();
  }
  \Drupal::service("entity_display.repository")
    ->getViewDisplay("node", "article", "default")
    ->setComponent("field_kvf_disp", ["type" => "key_value", "settings" => ["value_only" => FALSE]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_kvf_disp formatter value_only=FALSE"
