#!/usr/bin/env bash
# Introspection SETUP: create a scheduled action reg_sched_known (7 days before) so it is discoverable.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $st = \Drupal::entityTypeManager()->getStorage("registration_scheduled_action");
  $sa = $st->load("reg_sched_known") ?: $st->create(["id"=>"reg_sched_known"]);
  $sa->set("label","Reg Sched Known")->set("status",TRUE)->set("weight",0)
     ->set("datetime",["length"=>7,"type"=>"days","position"=>"before"])
     ->set("target_langcode","")->set("plugin","registration_send_email_action")->set("configuration",[]);
  $sa->save();
' >/dev/null 2>&1
echo "setup: registration_scheduled_action.reg_sched_known (7 days before, registration_send_email_action)"
