#!/usr/bin/env bash
# Execution RESET: ensure field_fsui_req + field_fsui_trigger2 text fields exist on Article and
# force field_fsui_req to have NO field_states_ui states (verify FAILS until agent adds a required state).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_fsui_req","field_fsui_trigger2"] as $f) {
    if (!FieldStorageConfig::loadByName("node",$f)) {
      FieldStorageConfig::create(["field_name"=>$f,"entity_type"=>"node","type"=>"string"])->save();
    }
    if (!FieldConfig::loadByName("node","article",$f)) {
      FieldConfig::create(["field_name"=>$f,"entity_type"=>"node","bundle"=>"article","label"=>ucfirst($f)])->save();
    }
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  foreach (["field_fsui_req","field_fsui_trigger2"] as $f) {
    $c = $fd->getComponent($f) ?: ["type"=>"string_textfield","weight"=>54,"region"=>"content"];
    unset($c["third_party_settings"]["field_states_ui"]);
    $fd->setComponent($f,$c);
  }
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fsui_req + field_fsui_trigger2 present, field_fsui_req has NO field_states"
