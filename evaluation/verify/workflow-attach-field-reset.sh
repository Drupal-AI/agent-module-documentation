#!/usr/bin/env bash
# Execution RESET: ensure a Workflow 'wf_attach' exists (creation/draft/published) but the Article
# content type does NOT yet have the workflow field 'field_wf_attach', so verify FAILS until the
# agent adds the field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
# remove the field if present
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_wf_attach")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_wf_attach")) { $fs->delete(); }
' >/dev/null 2>&1
# (re)build the workflow via raw config
drush php:eval '
  $cf = \Drupal::configFactory(); $wid = "wf_attach"; $uuid = \Drupal::service("uuid");
  foreach ($cf->listAll("") as $n) { if (strpos($n, $wid) !== FALSE) $cf->getEditable($n)->delete(); }
  $mkstate = function($sid,$label,$w,$sys) use ($cf,$wid,$uuid) {
    $cf->getEditable("workflow.state.$sid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>["config"=>["workflow.workflow.$wid"]],"id"=>$sid,"label"=>$label,"weight"=>$w,"module"=>"workflow","wid"=>$wid,"sysid"=>$sys,"single_state_widget"=>""])->save(); };
  $cf->getEditable("workflow.workflow.$wid")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>[],"id"=>$wid,"label"=>"WF Attach","module"=>"workflow","options"=>["name_as_title"=>1,"fieldset"=>0,"options"=>"radios","schedule_enable"=>0,"schedule_timezone"=>1,"always_update_entity"=>0,"comment_log_node"=>1,"watchdog_log"=>1]])->save();
  $mkstate("${wid}_creation","Creation",-50,1);
  $mkstate("${wid}_draft","Draft",0,0);
  $mkstate("${wid}_published","Published",1,0);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: workflow wf_attach present; field_wf_attach NOT on node.article"
