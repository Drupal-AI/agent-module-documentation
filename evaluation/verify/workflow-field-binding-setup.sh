#!/usr/bin/env bash
# Introspection SETUP: create a Workflow 'wf_field' and attach it to the Article content type as a
# Workflow field 'field_wf_known'. An inspecting agent should read the field storage and report
# which workflow (workflow_type) the field is bound to. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory(); $wid = "wf_field"; $uuid = \Drupal::service("uuid");
  foreach ($cf->listAll("") as $n) { if (strpos($n, $wid) !== FALSE) $cf->getEditable($n)->delete(); }
  $mkstate = function($sid,$label,$w,$sys) use ($cf,$wid,$uuid) {
    $cf->getEditable("workflow.state.$sid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>["config"=>["workflow.workflow.$wid"]],"id"=>$sid,"label"=>$label,"weight"=>$w,"module"=>"workflow","wid"=>$wid,"sysid"=>$sys,"single_state_widget"=>""])->save(); };
  $cf->getEditable("workflow.workflow.$wid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>[],"id"=>$wid,"label"=>"WF Field","module"=>"workflow","options"=>["name_as_title"=>1,"fieldset"=>0,"options"=>"radios","schedule_enable"=>0,"schedule_timezone"=>1,"always_update_entity"=>0,"comment_log_node"=>1,"watchdog_log"=>1]])->save();
  $mkstate("${wid}_creation","Creation",-50,1);
  $mkstate("${wid}_open","Open",0,0);
' >/dev/null 2>&1
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_wf_known")) {
    FieldStorageConfig::create(["field_name"=>"field_wf_known","entity_type"=>"node","type"=>"workflow","settings"=>["workflow_type"=>"wf_field"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_wf_known")) {
    FieldConfig::create(["field_name"=>"field_wf_known","entity_type"=>"node","bundle"=>"article","label"=>"Editorial state"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_wf_known on node.article bound to workflow wf_field"
