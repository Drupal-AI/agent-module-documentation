#!/usr/bin/env bash
# Introspection SETUP: create field_fsui_state on Article with a field_states_ui 'required' state
# (target=title, comparison=filled). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fsui_state")) {
    FieldStorageConfig::create(["field_name"=>"field_fsui_state","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fsui_state")) {
    FieldConfig::create(["field_name"=>"field_fsui_state","entity_type"=>"node","bundle"=>"article","label"=>"FSUI State"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd->getComponent("field_fsui_state") ?: ["type"=>"string_textfield","weight"=>51,"region"=>"content"];
  $c["third_party_settings"]["field_states_ui"]["field_states"] = [[
    "id"=>"required","data"=>["target"=>"title","comparison"=>"filled","value"=>TRUE],
    "uuid"=>\Drupal::service("uuid")->generate(),
  ]];
  $fd->setComponent("field_fsui_state",$c)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fsui_state has field_states_ui state id=required"
