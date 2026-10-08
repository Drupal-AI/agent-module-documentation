#!/usr/bin/env bash
# Introspection SETUP: build workflow 'wa_wf' (creation/draft/review) and grant the content_editor
# role view+update access to the 'wa_wf_review' state via workflow_access.role. An inspecting agent
# should read workflow_access.role and report which role can edit content in the review state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory(); $wid = "wa_wf"; $uuid = \Drupal::service("uuid");
  foreach ($cf->listAll("") as $n) { if (strpos($n, $wid) !== FALSE) $cf->getEditable($n)->delete(); }
  $mkstate = function($sid,$label,$w,$sys) use ($cf,$wid,$uuid) { $cf->getEditable("workflow.state.$sid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>["config"=>["workflow.workflow.$wid"]],"id"=>$sid,"label"=>$label,"weight"=>$w,"module"=>"workflow","wid"=>$wid,"sysid"=>$sys,"single_state_widget"=>""])->save(); };
  $cf->getEditable("workflow.workflow.$wid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>[],"id"=>$wid,"label"=>"WA WF","module"=>"workflow","options"=>["name_as_title"=>1,"fieldset"=>0,"options"=>"radios","schedule_enable"=>0,"schedule_timezone"=>1,"always_update_entity"=>0,"comment_log_node"=>1,"watchdog_log"=>1]])->save();
  $mkstate("${wid}_creation","Creation",-50,1); $mkstate("${wid}_draft","Draft",0,0); $mkstate("${wid}_review","Needs Review",1,0);
' >/dev/null 2>&1
drush php:eval '
  use Drupal\workflow_access\Entity\WorkflowAccessState;
  $a = new WorkflowAccessState(["id"=>"wa_wf_review"]);
  $data = ["content_editor"=>["grant_view"=>1,"grant_update"=>1,"grant_delete"=>0]];
  $a->insertAccess($data);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: workflow_access.role[wa_wf_review] grants content_editor view+update"
