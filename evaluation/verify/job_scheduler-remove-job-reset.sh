#!/usr/bin/env bash
# Execution RESET: schedule a 'js_remove' job so it EXISTS; verify (which wants it gone) FAILS
# until the agent removes it. removeAll first for idempotence. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $m = \Drupal::service("job_scheduler.manager");
  $m->removeAll("js_remove", "js_remove_type");
  $m->set(["name"=>"js_remove","type"=>"js_remove_type","id"=>9,"period"=>3600,"periodic"=>TRUE]);
' >/dev/null 2>&1
echo "reset: 'js_remove' scheduled (present)"
