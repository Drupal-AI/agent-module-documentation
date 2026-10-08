#!/usr/bin/env bash
# Execution RESET: child field field_dfu_child already uses dependent_fields_selection depending
# on field_dfu_parent, but reference_parent_by_uuid=FALSE, so a verify needing UUID FAILS until set.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_dfu_parent","field_dfu_child"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name" => $fn, "entity_type" => "node", "type" => "entity_reference", "settings" => ["target_type" => "node"]])->save();
    }
  }
  if (!FieldConfig::loadByName("node","article","field_dfu_parent")) {
    FieldConfig::create(["field_name"=>"field_dfu_parent","entity_type"=>"node","bundle"=>"article","label"=>"DFU Parent","settings"=>["handler"=>"default:node","handler_settings"=>[]]])->save();
  }
  $child = FieldConfig::loadByName("node","article","field_dfu_child") ?: FieldConfig::create(["field_name"=>"field_dfu_child","entity_type"=>"node","bundle"=>"article","label"=>"DFU Child"]);
  $child->setSetting("handler", "dependent_fields_selection");
  $child->setSetting("handler_settings", ["dependent_fields_view"=>["view_name"=>"content","display_name"=>"entity_reference_1","parent_field"=>"field_dfu_parent","reference_parent_by_uuid"=>false,"arguments"=>[]]]);
  $child->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_dfu_child dependent (reference_parent_by_uuid=false)"
