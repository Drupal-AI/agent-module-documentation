#!/usr/bin/env bash
# Execution RESET: ensure field_eabrf_task (entity_access_by_role_field) exists on Article with
# empty_roles_access_fallback = neutral, so verify FAILS until the agent changes it to forbidden.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_eabrf_task")) {
    FieldStorageConfig::create(["field_name"=>"field_eabrf_task","entity_type"=>"node","type"=>"entity_access_by_role_field"])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_eabrf_task");
  if (!$fc) {
    $fc = FieldConfig::create(["field_name"=>"field_eabrf_task","entity_type"=>"node","bundle"=>"article","label"=>"Role access (task)","settings"=>["operations"=>["view"=>"view","update"=>0,"delete"=>0],"empty_roles_access_fallback"=>"neutral"]]);
  } else {
    $fc->setSetting("empty_roles_access_fallback", "neutral");
  }
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_eabrf_task empty_roles_access_fallback=neutral"
