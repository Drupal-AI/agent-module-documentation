#!/usr/bin/env bash
# Execution RESET (cacheflush_cron): remove any cfc_task preset (and its cron job) so verify FAILS
# until the agent creates a cron-enabled preset. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\ultimate_cron\Entity\CronJob;
  foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cfc_task"]) as $e){
    if($j=CronJob::load("cacheflush_preset_".$e->id())){$j->delete();}
    $e->delete();
  }
' >/dev/null 2>&1
echo "reset: no cfc_task preset / cron job"
