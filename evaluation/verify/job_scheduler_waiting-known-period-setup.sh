#!/usr/bin/env bash
# Introspection SETUP: schedule 'jsw_due' with period 7200. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $m = \Drupal::service("job_scheduler.manager");
  $m->removeAll("jsw_due", "jsw_due_type");
  $m->set(["name"=>"jsw_due","type"=>"jsw_due_type","id"=>1,"period"=>7200,"periodic"=>TRUE]);
' >/dev/null 2>&1
echo "setup: job 'jsw_due' period=7200 scheduled"
