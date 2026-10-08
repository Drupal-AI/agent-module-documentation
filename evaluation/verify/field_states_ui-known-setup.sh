#!/usr/bin/env bash
# Introspection SETUP: create a text field field_fsui_known on Article and configure a
# field_states_ui 'visible' state on its widget (target=title, comparison=value). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fsui_known")) {
    FieldStorageConfig::create(["field_name"=>"field_fsui_known","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fsui_known")) {
    FieldConfig::create(["field_name"=>"field_fsui_known","entity_type"=>"node","bundle"=>"article","label"=>"FSUI Known"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd->getComponent("field_fsui_known") ?: ["type"=>"string_textfield","weight"=>50,"region"=>"content"];
  $c["third_party_settings"]["field_states_ui"]["field_states"] = [[
    "id"=>"visible","data"=>["target"=>"title","comparison"=>"value","value"=>"Show"],
    "uuid"=>\Drupal::service("uuid")->generate(),
  ]];
  $fd->setComponent("field_fsui_known",$c)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fsui_known has field_states_ui state id=visible target=title"
