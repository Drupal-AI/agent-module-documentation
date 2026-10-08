#!/usr/bin/env bash
# Introspection SETUP: create an ORPHANED workflow state 'wc_orphan' whose parent workflow
# (wc_ghost) does not exist, so Workflow Cleanup would list it under "Orphaned States". Weight is
# a proper int. An inspecting agent should identify the orphaned state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory(); $uuid = \Drupal::service("uuid");
  $cf->getEditable("workflow.state.wc_orphan")->setData(["uuid"=>$uuid->generate(),"langcode"=>"en","status"=>true,"dependencies"=>[],"id"=>"wc_orphan","label"=>"Orphan State","weight"=>0,"module"=>"workflow","wid"=>"wc_ghost","sysid"=>0,"single_state_widget"=>""])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: orphaned state wc_orphan (workflow wc_ghost missing)"
