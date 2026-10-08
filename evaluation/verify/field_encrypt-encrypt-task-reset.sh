#!/usr/bin/env bash
# Execution RESET: ensure a namespaced string field field_fe_task exists on Article and is NOT
# encrypted, so verify FAILS until the agent turns encryption on. Config-only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fe_task")) {
    FieldStorageConfig::create(["field_name"=>"field_fe_task","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fe_task")) {
    FieldConfig::create(["field_name"=>"field_fe_task","entity_type"=>"node","bundle"=>"article","label"=>"FE Task Secret"])->save();
  }
  $fs = FieldStorageConfig::loadByName("node","field_fe_task");
  $fs->unsetThirdPartySetting("field_encrypt","encrypt");
  $fs->unsetThirdPartySetting("field_encrypt","properties");
  $fs->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fe_task present, encryption OFF"
