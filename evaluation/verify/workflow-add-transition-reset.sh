#!/usr/bin/env bash
# Execution RESET: build Workflow 'wf_trans' with states creation/draft/published/archived and
# transitions creation->draft and draft->published, but NO published->archived transition, so
# verify FAILS until the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory(); $wid = "wf_trans"; $uuid = \Drupal::service("uuid");
  foreach ($cf->listAll("") as $n) { if (strpos($n, $wid) !== FALSE) $cf->getEditable($n)->delete(); }
  $mkstate = function($sid,$label,$w,$sys) use ($cf,$wid,$uuid) {
    $cf->getEditable("workflow.state.$sid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>["config"=>["workflow.workflow.$wid"]],"id"=>$sid,"label"=>$label,"weight"=>$w,"module"=>"workflow","wid"=>$wid,"sysid"=>$sys,"single_state_widget"=>""])->save(); };
  $mktrans = function($tid,$from,$to) use ($cf,$wid,$uuid) {
    $cf->getEditable("workflow.transition.$tid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>["config"=>["workflow.state.$from","workflow.state.$to","workflow.workflow.$wid"]],"id"=>$tid,"label"=>"","module"=>"workflow","from_sid"=>$from,"to_sid"=>$to,"roles"=>["authenticated"]])->save(); };
  $cf->getEditable("workflow.workflow.$wid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>[],"id"=>$wid,"label"=>"WF Trans","module"=>"workflow","options"=>["name_as_title"=>1,"fieldset"=>0,"options"=>"radios","schedule_enable"=>0,"schedule_timezone"=>1,"always_update_entity"=>0,"comment_log_node"=>1,"watchdog_log"=>1]])->save();
  $mkstate("${wid}_creation","Creation",-50,1);
  $mkstate("${wid}_draft","Draft",0,0);
  $mkstate("${wid}_published","Published",1,0);
  $mkstate("${wid}_archived","Archived",2,0);
  $mktrans("${wid}_creation_draft","${wid}_creation","${wid}_draft");
  $mktrans("${wid}_draft_published","${wid}_draft","${wid}_published");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: workflow wf_trans present; no published->archived transition yet"
