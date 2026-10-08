#!/usr/bin/env bash
# Introspection SETUP: schedule 'jsw_probe' with job id 321. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $m = \Drupal::service("job_scheduler.manager");
  $m->removeAll("jsw_probe", "jsw_probe_type");
  $m->set(["name"=>"jsw_probe","type"=>"jsw_probe_type","id"=>321,"period"=>3600,"periodic"=>TRUE]);
' >/dev/null 2>&1
echo "setup: job 'jsw_probe' id=321 scheduled"
