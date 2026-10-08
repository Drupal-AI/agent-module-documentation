#!/usr/bin/env bash
# Introspection SETUP: create parent + child entity_reference fields on Article; configure the
# child (field_dfx_child) to use the dependent_fields_selection handler depending on
# field_dfx_parent, so an agent can read the handler + parent field back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_dfx_parent","field_dfx_child"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name" => $fn, "entity_type" => "node", "type" => "entity_reference", "settings" => ["target_type" => "node"]])->save();
    }
  }
  if (!FieldConfig::loadByName("node","article","field_dfx_parent")) {
    FieldConfig::create(["field_name"=>"field_dfx_parent","entity_type"=>"node","bundle"=>"article","label"=>"DFX Parent","settings"=>["handler"=>"default:node","handler_settings"=>[]]])->save();
  }
  $child = FieldConfig::loadByName("node","article","field_dfx_child");
  if (!$child) {
    $child = FieldConfig::create(["field_name"=>"field_dfx_child","entity_type"=>"node","bundle"=>"article","label"=>"DFX Child"]);
  }
  $child->setSetting("handler", "dependent_fields_selection");
  $child->setSetting("handler_settings", ["dependent_fields_view"=>["view_name"=>"content","display_name"=>"entity_reference_1","parent_field"=>"field_dfx_parent","reference_parent_by_uuid"=>false,"arguments"=>[]]]);
  $child->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_dfx_child handler=dependent_fields_selection parent_field=field_dfx_parent"
