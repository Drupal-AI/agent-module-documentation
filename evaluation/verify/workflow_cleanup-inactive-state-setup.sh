#!/usr/bin/env bash
# Introspection SETUP: build workflow 'wc_wf' with an active Draft state and an INACTIVE state
# 'wc_wf_old' (status=false) belonging to the workflow, so Workflow Cleanup lists it under
# "Inactive (Deleted) States". An inspecting agent should identify the inactive state. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory(); $wid = "wc_wf"; $uuid = \Drupal::service("uuid");
  foreach ($cf->listAll("") as $n) { if (strpos($n, $wid) !== FALSE) $cf->getEditable($n)->delete(); }
  $mkstate = function($sid,$label,$w,$sys,$status) use ($cf,$wid,$uuid) { $cf->getEditable("workflow.state.$sid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>$status,"dependencies"=>["config"=>["workflow.workflow.$wid"]],"id"=>$sid,"label"=>$label,"weight"=>$w,"module"=>"workflow","wid"=>$wid,"sysid"=>$sys,"single_state_widget"=>""])->save(); };
  $cf->getEditable("workflow.workflow.$wid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>[],"id"=>$wid,"label"=>"WC WF","module"=>"workflow","options"=>["name_as_title"=>1,"fieldset"=>0,"options"=>"radios","schedule_enable"=>0,"schedule_timezone"=>1,"always_update_entity"=>0,"comment_log_node"=>1,"watchdog_log"=>1]])->save();
  $mkstate("${wid}_creation","Creation",-50,1,true); $mkstate("${wid}_draft","Draft",0,0,true); $mkstate("${wid}_old","Old Inactive",1,0,false);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: workflow wc_wf with inactive state wc_wf_old"
