#!/usr/bin/env bash
# Execution RESET: build workflow 'wa_wf' (creation/draft/review) and ensure NO workflow_access
# grant exists for content_editor on wa_wf_review, so verify FAILS until the agent grants it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory(); $wid = "wa_wf"; $uuid = \Drupal::service("uuid");
  foreach ($cf->listAll("") as $n) { if (strpos($n, $wid) !== FALSE) $cf->getEditable($n)->delete(); }
  $mkstate = function($sid,$label,$w,$sys) use ($cf,$wid,$uuid) { $cf->getEditable("workflow.state.$sid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>["config"=>["workflow.workflow.$wid"]],"id"=>$sid,"label"=>$label,"weight"=>$w,"module"=>"workflow","wid"=>$wid,"sysid"=>$sys,"single_state_widget"=>""])->save(); };
  $cf->getEditable("workflow.workflow.$wid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>[],"id"=>$wid,"label"=>"WA WF","module"=>"workflow","options"=>["name_as_title"=>1,"fieldset"=>0,"options"=>"radios","schedule_enable"=>0,"schedule_timezone"=>1,"always_update_entity"=>0,"comment_log_node"=>1,"watchdog_log"=>1]])->save();
  $mkstate("${wid}_creation","Creation",-50,1); $mkstate("${wid}_draft","Draft",0,0); $mkstate("${wid}_review","Needs Review",1,0);
  $cf->getEditable("workflow_access.role")->clear("wa_wf_review")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: wa_wf present; no grant on wa_wf_review"
