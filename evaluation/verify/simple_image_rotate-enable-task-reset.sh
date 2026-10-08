#!/usr/bin/env bash
# Execution RESET: ensure image field field_sir_task exists on Article with enable_rotate FALSE
# (so verify FAILS until the agent enables it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_sir_task")) {
    FieldStorageConfig::create(["field_name"=>"field_sir_task","entity_type"=>"node","type"=>"image"])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_sir_task");
  if (!$fc) { $fc = FieldConfig::create(["field_name"=>"field_sir_task","entity_type"=>"node","bundle"=>"article","label"=>"SIR task"]); }
  $fc->setThirdPartySetting("simple_image_rotate","enable_rotate",FALSE); $fc->save();
' >/dev/null 2>&1
echo "reset: field_sir_task present with enable_rotate=FALSE"
