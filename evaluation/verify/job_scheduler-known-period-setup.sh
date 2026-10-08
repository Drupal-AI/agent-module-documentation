#!/usr/bin/env bash
# Introspection SETUP: schedule a known job 'js_probe' with period=3600. removeAll first for
# idempotence. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $m = \Drupal::service("job_scheduler.manager");
  $m->removeAll("js_probe", "js_probe_type");
  $m->set(["name"=>"js_probe","type"=>"js_probe_type","id"=>1,"period"=>3600,"periodic"=>TRUE]);
' >/dev/null 2>&1
echo "setup: job 'js_probe' period=3600 scheduled"
