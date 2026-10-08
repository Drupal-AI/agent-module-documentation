#!/usr/bin/env bash
# Introspection SETUP: dependent child field field_dfa_child depending on field_dfa_parent, with
# extra View arguments configured (arguments: ["5"]), so an agent can read the arguments back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_dfa_parent","field_dfa_child"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name" => $fn, "entity_type" => "node", "type" => "entity_reference", "settings" => ["target_type" => "node"]])->save();
    }
  }
  if (!FieldConfig::loadByName("node","article","field_dfa_parent")) {
    FieldConfig::create(["field_name"=>"field_dfa_parent","entity_type"=>"node","bundle"=>"article","label"=>"DFA Parent","settings"=>["handler"=>"default:node","handler_settings"=>[]]])->save();
  }
  $child = FieldConfig::loadByName("node","article","field_dfa_child") ?: FieldConfig::create(["field_name"=>"field_dfa_child","entity_type"=>"node","bundle"=>"article","label"=>"DFA Child"]);
  $child->setSetting("handler", "dependent_fields_selection");
  $child->setSetting("handler_settings", ["dependent_fields_view"=>["view_name"=>"content","display_name"=>"entity_reference_1","parent_field"=>"field_dfa_parent","reference_parent_by_uuid"=>true,"arguments"=>["published"]]]);
  $child->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_dfa_child reference_parent_by_uuid=true arguments=[published]"
