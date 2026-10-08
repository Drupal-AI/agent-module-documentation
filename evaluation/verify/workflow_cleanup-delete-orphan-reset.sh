#!/usr/bin/env bash
# Execution RESET: (re)create the orphaned state wc_orphan so verify FAILS until the agent deletes
# it with Workflow Cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory(); $uuid = \Drupal::service("uuid");
  $cf->getEditable("workflow.state.wc_orphan")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>[],"id"=>"wc_orphan","label"=>"Orphan State","weight"=>0,"module"=>"workflow","wid"=>"wc_ghost","sysid"=>0,"single_state_widget"=>""])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: orphaned state wc_orphan present"
