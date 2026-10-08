#!/usr/bin/env bash
# Execution RESET: ensure File field field_plw_task exists on Article with the core file_generic
# widget, so verify FAILS until the agent switches it to plupload_file_widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_plw_task")) { FieldStorageConfig::create(["field_name"=>"field_plw_task","entity_type"=>"node","type"=>"file","cardinality"=>1])->save(); }
  if (!FieldConfig::loadByName("node","article","field_plw_task")) { FieldConfig::create(["field_name"=>"field_plw_task","entity_type"=>"node","bundle"=>"article","label"=>"PLW Task"])->save(); }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_plw_task", ["type"=>"file_generic","weight"=>50,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_plw_task uses core file_generic widget"
