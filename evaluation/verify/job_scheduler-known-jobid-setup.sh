#!/usr/bin/env bash
# Introspection SETUP: schedule 'js_target' with job id 7777. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $m = \Drupal::service("job_scheduler.manager");
  $m->removeAll("js_target", "js_target_type");
  $m->set(["name"=>"js_target","type"=>"js_target_type","id"=>7777,"period"=>86400,"periodic"=>TRUE]);
' >/dev/null 2>&1
echo "setup: job 'js_target' id=7777 scheduled"
