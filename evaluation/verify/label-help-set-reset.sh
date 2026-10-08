#!/usr/bin/env bash
# Execution RESET: ensure field_lh_task exists on Article and force its Label Help text OFF (unset),
# so verify FAILS until the agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_lh_task")) {
    FieldStorageConfig::create(["field_name" => "field_lh_task", "entity_type" => "node", "type" => "string"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_lh_task");
  if (!$fc) {
    $fc = FieldConfig::create(["field_name" => "field_lh_task", "entity_type" => "node", "bundle" => "article", "label" => "LH Task"]);
    $fc->save();
    $fc = FieldConfig::loadByName("node", "article", "field_lh_task");
  }
  $fc->unsetThirdPartySetting("label_help", "label_help_description");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_lh_task on node.article with NO label help"
