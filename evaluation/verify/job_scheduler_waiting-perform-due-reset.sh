#!/usr/bin/env bash
# Execution RESET: create a DUE (overdue), non-periodic 'jsw_task' job (next in the past,
# scheduled=0) so it is pending; verify (which wants it gone) FAILS until the agent performs it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\job_scheduler\Entity\JobSchedule;
  \Drupal::service("job_scheduler.manager")->removeAll("jsw_task","jsw_task_type");
  JobSchedule::create([
    "name"=>"jsw_task","type"=>"jsw_task_type","id"=>1,"period"=>3600,"periodic"=>FALSE,
    "next"=>time()-100,"scheduled"=>0,"last"=>0,
  ])->save();
' >/dev/null 2>&1
echo "reset: due 'jsw_task' job created (next in past)"
